class SubDemo < ApplicationRecord





  def validate_any_promo(total_discount)
    total = 0
    total_discount.each do |td|
      total += td
    end

    if total > 0
      true
    else
      false
    end
  end

  def verify_code
    code = params[:code].downcase
    if PromoCode.where(code: code).exists?
      @promo_code = PromoCode.where(code: code).first

      #check for user specific code
      if @promo_code.user_id and @promo_code.user_id == current_user.id

        discount_type = 'percentage'
        discount_value = @promo_code.discount
        if @promo_code.discount_amount and @promo_code.discount_amount>0
          discount_type  = 'flat'
          discount_value = @promo_code.discount_amount
        end

        #valid for this user
        pc = @promo_code
        #@promo_code.destroy!
        render json: return_success_formated_json('Code Exists', {category: pc.category, code: pc.code, promo_code_type: pc.promo_code_type, discount_type: discount_type, discount_value: discount_value, user_id: current_user.id })

      elsif (@promo_code.category and @promo_code.category!='') or @promo_code.offers_ids.any?

        if params[:offer_id] and Offer.exists? params[:offer_id]
            offer_ids = params[:offer_id].split(/\s*,\s*/)
          offer = Offer.includes(:cities).find(offer_ids)
          discount_type = 'percentage'
          discount_value = @promo_code.discount
          if @promo_code.discount_amount and @promo_code.discount_amount > 0
            discount_type = 'flat'
            discount_value = @promo_code.discount_amount
          end
          total_discount = []
          offer.each do |o|
            puts "Loop  #{total_discount}  offerid  #{o.id}"
            if (@promo_code.city_id.to_i.in?(o.cities.ids)) or (@promo_code.doctor_id == (o.doctor_id)) or (@promo_code.sub_category.in?(o.sub_category)) or (@promo_code.category.in?(o.category))
              if promo_redeem_validate(@promo_code)
                total_discount << discount_value
              else
                total_discount << 0
              end
            else
              total_discount << 0
            end
          end

          is_valid = validate_any_promo(total_discount)
          if is_valid
            render json: return_success_formated_json("Code Exists", { discount_type: discount_type, discount_value: total_discount })
          else
            render json: return_error_formated_json_wm(t('invalid_promo_code'), @promo_code, 'Not valid for this offer.')
          end

        else
          #invalid offer_id or offer_id not provide
          render json: return_error_formated_json_wm(t('invalid_promo_code'), @promo_code, 'Provide correct offer id.')
        end
      else
        #universal code
        discount_type  = 'percentage'
        discount_value = @promo_code.discount
        if @promo_code.discount_amount and @promo_code.discount_amount>0
          discount_type  = 'flat'
          discount_value = @promo_code.discount_amount
        end
        promo_redeem_validation(@promo_code,discount_type,discount_value,'Code Exists universally')
      end
    else
      #code not provided
      render json: return_error_formated_json_wm(t('invalid_promo_code'), @promo_code, 'Incorrect promo code.')
    end
  end

  def promo_redeem_validate(promo_code)
    if promo_code.one_time?
      #one time code
      count = current_user.appointments.confirmed.size

      if count < 1
        #valid for this offer and user one time
        return true
      else
        #user has already used it one time
        return false
      end
    else
      #not one time code
      true
    end
  end
  def promo_redeem_validation(promo_code,discount_type,discount_value,message)
    if promo_code.one_time?
      #one time code
      count = current_user.appointments.confirmed.size
      city = City.where(id: promo_code.city_id)
      if count < 1
        #valid for this offer and user one time
        render json: return_success_formated_json(message, {category: promo_code.category, code: promo_code.code, promo_code_type: promo_code.promo_code_type, discount_type: discount_type, discount_value: discount_value,
                                                            sub_category: promo_code.sub_category, city: city, doctor_id: promo_code.doctor_id,  })
      else
        #user has already used it one time
        render json: return_error_formated_json_wm(t('single_use_code'), promo_code, 'تم استخدام الكود مسبقا ولا يمكن استخدامه مره أخرى')
      end
    else
      #not one time code
      render json: return_success_formated_json(message, {category: promo_code.category, code: promo_code.code, promo_code_type: promo_code.promo_code_type, discount_type: discount_type, discount_value: discount_value,
                                                          sub_category: promo_code.sub_category, city: city, doctor_id: promo_code.doctor_id,  })
    end
  end









end
