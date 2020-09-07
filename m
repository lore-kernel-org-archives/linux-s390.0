Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729635AbgIGOET (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Sep 2020 10:04:19 -0400
Subject: Re: [PATCH] KVM: s390: Introduce storage key removal facility
References: <20200907131410.11474-1-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <b34e559a-8292-873f-8d33-1e7ce819f4d5@de.ibm.com>
Date: Mon, 7 Sep 2020 15:50:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200907131410.11474-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, david@redhat.com, linux-s390@vger.kernel.org



On 07.09.20 15:14, Janosch Frank wrote:
[...]

> @@ -565,7 +566,44 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>  		rc = handle_partial_execution(vcpu);
>  		break;
>  	case ICPT_KSS:
> -		rc = kvm_s390_skey_check_enable(vcpu);
> +		if (likely(!test_kvm_facility(vcpu->kvm, 169))) {

please no "likely" unless really necessary. This is for both cases slow path.

> +			rc = kvm_s390_skey_check_enable(vcpu);
> +		} else {
> +			/*
> +			 * Storage key removal facility emulation.
> +			 *
> +			 * KSS is the same priority as instruction
> +			 * interception. Hence we need handling here
> +			 * and in the instruction emulation code.
> +			 *
> +			 * lpsw(e) needs to store the problematic psw
> +			 * as the program old psw. Calling the
> +			 * handlers directly does that without falsely
> +			 * increasing stat counters.
> +			 */

I do not understand this comment and the code below. As the fault is suppressing
we should NOT store the program old psw?

> +			switch (vcpu->arch.sie_block->ipa) {
> +			case 0xb2b2:
> +				kvm_s390_forward_psw(vcpu, kvm_s390_get_ilen(vcpu));
> +				rc = kvm_s390_handle_b2(vcpu);
> +				break;
> +			case 0x8200:
 +				kvm_s390_forward_psw(vcpu, kvm_s390_get_ilen(vcpu));
> +				rc = kvm_s390_handle_lpsw(vcpu);
> +				break;
> +			case 0:
> +				/* Interception caused by exception new PSW key */
> +				rc = kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +				break;
> +			default:
> +				/*
> +				 * KSS is nullifying (no psw forward),
> +				 * SKRF issues suppressing SPECIAL
> +				 * OPS, so we need to forward by hand.
> +				 */
> +				kvm_s390_forward_psw(vcpu, kvm_s390_get_ilen(vcpu));
> +				rc = kvm_s390_inject_program_int(vcpu, PGM_SPECIAL_OPERATION);
> +			}
> +		}
[...]
