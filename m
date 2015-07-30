From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 1/1] KVM: s390: Fix hang VCPU hang/loop regression
Date: Thu, 30 Jul 2015 13:38:29 +0200
Message-ID: <55BA0CB5.1090605@redhat.com>
References: <1438255366-25805-1-git-send-email-borntraeger@de.ibm.com>
 <1438255366-25805-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438255366-25805-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On 30/07/2015 13:22, Christian Borntraeger wrote:
>  static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
>  {
> -	if (!vcpu->requests)
> -		return 0;
>  retry:
>  	kvm_s390_vcpu_request_handled(vcpu);
> +	if (!vcpu->requests)
> +		return 0;
>  	/*

Should kvm_s390_vcpu_request_handled(vcpu); go before the retry label?

It shouldn't be too common to have two requests, and you're doing an 
extra atomic operation to clear PROG_REQUEST.

Or in fact, if you do this:

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 05e99b8ef465..a22a13fefb42 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1080,7 +1080,7 @@ static inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
 
 static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
 {
-	if (test_bit(req, &vcpu->requests)) {
+	if (vcpu->requests && test_bit(req, &vcpu->requests)) {
 		clear_bit(req, &vcpu->requests);
 		return true;
 	} else {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f32f843a3631..08e24dfc60d3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1742,10 +1742,7 @@ static bool ibs_enabled(struct kvm_vcpu *vcpu)
 
 static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 {
-retry:
 	kvm_s390_vcpu_request_handled(vcpu);
-	if (!vcpu->requests)
-		return 0;
 	/*
 	 * We use MMU_RELOAD just to re-arm the ipte notifier for the
 	 * guest prefix page. gmap_ipte_notify will wait on the ptl lock.
@@ -1760,12 +1757,10 @@ retry:
 				      PAGE_SIZE * 2);
 		if (rc)
 			return rc;
-		goto retry;
 	}
 
 	if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu)) {
 		vcpu->arch.sie_block->ihcpu = 0xffff;
-		goto retry;
 	}
 
 	if (kvm_check_request(KVM_REQ_ENABLE_IBS, vcpu)) {
@@ -1774,7 +1769,6 @@ retry:
 			atomic_set_mask(CPUSTAT_IBS,
 					&vcpu->arch.sie_block->cpuflags);
 		}
-		goto retry;
 	}
 
 	if (kvm_check_request(KVM_REQ_DISABLE_IBS, vcpu)) {
@@ -1783,11 +1777,11 @@ retry:
 			atomic_clear_mask(CPUSTAT_IBS,
 					  &vcpu->arch.sie_block->cpuflags);
 		}
-		goto retry;
 	}
 
 	/* nothing to do, just clear the request */
-	clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
+	if (vcpu->requests)
+		clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
 
 	return 0;
 }

... the compiler should be able to thread all the jumps together.  The
resulting code should be the same or better assuming that two requests
are rare.

This of course should be for 4.3---I've pulled your branch into kvm/master.

Paolo
