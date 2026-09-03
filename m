Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE294F0553
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456043; cv=none; b=lUGY/WBXoWyP7/Dg8g9oOfjbSQlv8IRGU12X+vVlE917rDCwxFJ2unCmZOY22IcwWtQi8t71owtUEKMZpUc/Vv5PzML1jlD/q/B/MUOv5IssSNUBYAKogXLuael7TytnsRLMrl+OVlP5fptGN0r/RQDCLtTQIHgrHr+U4YpqMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456043; c=relaxed/simple;
	bh=/OTLAlcDX/VYmq2Sx2Hf2JVMKnw2hyeEfeoAFuc3tlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CJ7rcu2MlrFTZjFlpGQbzboSFd+bv+NNeCnDEthbs+1tmhkljHfVTOv7sRrOB7p2WQ9x5X5vZu/3VePtxdGf+QWJBC3MGrpiOSlquMuURNtu851ohmjA0Y2dFTFd6IbUPTSFcEa4jM2+BBXfH5ZKt/cyE5zY0MoujUhY/Kytty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipg3pJPQ; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipg3pJPQ"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db0a41434bso1239765ad.0
        for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788456041; x=1789060841; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=abT7Pvw9efwpChS8BOp+LMmzEtc1Cbt9UKhqN1YGeyU=;
        b=ipg3pJPQKLjDGM+FglLiVy7Ss2oYHCoCctsTQobNxb3Qc4Dkkh8aJ9xAvBQlSdBvDv
         pYshF6iOJga6p9tAtmem+4PvOLbfY7pSR7XXk9Veq8Odt1pzsZA+hNgcSNe+8ykoj9Ne
         KyB9d8pzXYikWQ8iO0y2SIPGIPPJX0UNDL40KcNWuh02vpAfq89HHXLR1beeSL8W3Zd1
         t281jLXKqk1Nsb9IrlkvJHzUA8LMns6ew9Jxt8W1KwgcQ7NWME/rhO9n+YAOTuy8Gn3x
         9zUkn4rQeEV85kn0WyOQr4jpe52DOyiXgb/vPCEVmYZd2TAf5XITn3uDjr2z7DVgdY0+
         Wwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788456041; x=1789060841;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abT7Pvw9efwpChS8BOp+LMmzEtc1Cbt9UKhqN1YGeyU=;
        b=Db2F/g1SmKoqVaeKzf434ZTGK27a2sFslR+olHqfSLnJisLryYa3qXfMS2heAg5zcS
         /zFagTezwq8kEbMCZ/tA2MZoKP/Pc1ud/eupWu/ZvcgEVOyKLyOj0v8VoiYG8HoXQr2r
         ohRKqv6SWrE09ntR5UTQ9PNTPcsqKUkXttX+VON9HB6IjJ6P+YmC879haQlapH79mEfd
         4juzvJzmJ8KICkJSBcqwXK/O074p1ScJcnfs5HW9rYmJS+/HTtMXZcD4bzOJ5H+4n2Ew
         UZZVnUfa+lpfe4NGnQivwAOdMuoKkj8B0Pd+3rzFFrZlrSglMlw2SHr+ndAM8qPfLb5D
         hZ/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxCLUgAt/KT60zxE3KkmAXpBMAItPskKPiuoBQMrTyY8SiROU6jRHUMMYIQaqNhnr4cCaXrxgtdXzaU@vger.kernel.org
X-Gm-Message-State: AFuF++mFNyhPdfbyI1OTeosOlAcHbEIiU52Zz60baihLG/J2EV+pzRKQ
	C0Bg+W4urqT87wDwkZ/wkrXYIHdguea0MXOZCUGAhZXp0pjeYMUoEQdMAWzHY6hwfXTGb4py9V+
	FgBnqJg==
X-Received: from plhz14.prod.google.com ([2002:a17:902:d9ce:b0:2d8:fd05:fde6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37d0:b0:2d7:344f:4a6f
 with SMTP id d9443c01a7336-2db1248d2f8mr7559625ad.8.1788456040506; Thu, 03
 Sep 2026 10:20:40 -0700 (PDT)
Date: Thu, 3 Sep 2026 10:20:39 -0700
In-Reply-To: <20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com>
Message-ID: <apmsZ3j0mtZq4Lp9@google.com>
Subject: Re: [PATCH v2] vfio: Use file-based reference counting for KVM
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, 
	Alex Williamson <alex@shazbot.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Eric Farman <farman@linux.ibm.com>, 
	Farhan Ali <alifm@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Tony Krowiak <akrowiak@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 03, 2026, Steffen Eiden wrote:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 65eb26a0520d..34b4c43908b3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1314,7 +1314,7 @@ void kvm_get_kvm(struct kvm *kvm)
>  {
>  	refcount_inc(&kvm->users_count);
>  }
> -EXPORT_SYMBOL_GPL(kvm_get_kvm);
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm);
>  
>  /*
>   * Make sure the vm is not during destruction, which is a safe version of
> @@ -1324,14 +1324,14 @@ bool kvm_get_kvm_safe(struct kvm *kvm)
>  {
>  	return refcount_inc_not_zero(&kvm->users_count);
>  }
> -EXPORT_SYMBOL_GPL(kvm_get_kvm_safe);
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm_safe);
>  
>  void kvm_put_kvm(struct kvm *kvm)
>  {
>  	if (refcount_dec_and_test(&kvm->users_count))
>  		kvm_destroy_vm(kvm);
>  }
> -EXPORT_SYMBOL_GPL(kvm_put_kvm);
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_put_kvm);

Please isolate the export changes.  They don't *need* to happen at the same time
as the VFIO changes, i.e. can be done on top.

>  /*
>   * Used to put a reference that was taken on behalf of an object associated
> @@ -1352,6 +1352,8 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
>  
>  	kvm_irqfd_release(kvm);
>  
> +	WRITE_ONCE(kvm->file, NULL);

Please move tracking the file in "struct kvm" to its own patch as well.

> +
>  	kvm_put_kvm(kvm);
>  	return 0;
>  }
> @@ -5496,6 +5498,15 @@ bool file_is_kvm(struct file *file)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
>  
> +struct kvm *file_to_kvm(struct file *file)
> +{
> +	if (!file_is_kvm(file))

file_is_kvm() should exist at the end of this series.  The only reason to ever
use file_is_kvm() is in advance of getting at "struct kvm", i.e. this should be
open coded in file_to_kvm().  Though as I suggested in the other subtread, it
woudl be kvm_file_to_kvm_fn(), i.e. kvm_file_to_kvm_x86() or kvm_file_to_kvm_s390().

And those changes can and should be done as prep work, i.e. in separate patches,
e.g. to end up with something like:

  1. Add kvm_file_to_kvm_fn() and use it on x86, i.e. replace the use of
     file_is_kvm() in arch/x86/kvm/svm/sev.c.
  2. Add kvm->file tracking.
  3. Switch VFIO to tracking the file.
  4. s/EXPORT_SYMBOL_GPL/EXPORT_SYMBOL_FOR_KVM_INTERNAL on the get/put APIs.
  5. Enable kvm_file_to_kvm_fn() on s390 and use kvm_file_to_kvm_s390() in the
     relevant code to prepare for s390+arm64.
