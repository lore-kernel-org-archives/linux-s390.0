Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516A15AC0
	for <linux-s390@vger.kernel.org>; Tue,  2 Jan 2024 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCxXarr+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704219562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nCI2XqcgtmfKoc7R6akxQ8EGO852Fcbw810Pl2QliE=;
	b=eCxXarr+kuEZqh/VU3cd26IJyjQQ4WEHNcWGw3VjgPf5c4WX7MWr+GFH5Q5CqRosmdcEnd
	5fY49JaUKo/JwFYSVhGXuta4OR+Vh+lzNnftb3P+ZrWtYWX/pkyXJAHoRkVMYBiI79nVxZ
	uEI3TxrvmsRTRlPNudO1R/eG/+I7f+E=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-2WW7b865MvK6LqdKwIC-XA-1; Tue, 02 Jan 2024 13:19:21 -0500
X-MC-Unique: 2WW7b865MvK6LqdKwIC-XA-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-467356bf734so1058900137.3
        for <linux-s390@vger.kernel.org>; Tue, 02 Jan 2024 10:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704219561; x=1704824361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nCI2XqcgtmfKoc7R6akxQ8EGO852Fcbw810Pl2QliE=;
        b=IIMDX2TQKgGn7pdfsLpKLAFR5jAkPegwAhWAanE/IZjE1eslT1xsFJG8bFnc9zEMwB
         LlwXQOW1guMUBp3iwoTcxkdSSM85lP6dFmogF5nR2lzc4Jri5jhkd57HcT+eb4Y6021o
         FxaozRvzc+SCvZ47n62iCDfszBZMRDusDACzcS87dPv8Vo73z4na8FaXjO599eLPPX2h
         O7tZVRkOyfM1dTLFG/Evfzc0uWT7p84tS5ZmqcIkeSPdYkgi32OOxo62u9NPXPR95niX
         OrOp02r6nX6pCqkIl9dexDJrvELS4uJVXyxhQfCoOtpbbWuXh4gLFCe/rDn5JJwXf/fA
         vqwg==
X-Gm-Message-State: AOJu0YwiMY0Vnqw2E4u4Y7kXiUrq3yClE9XnR5cqsv4446x9Ps+EgVUS
	Syj5ztcQ/MosrQeLwFEyxidf/1oU7zOaH4AoPzETdE3CP+wzMVvHpZ1GcoJG75LdtbWUlE1t9JE
	/VEVdFbOamp1hCAwmPVVGuBoE6ueE5+yy/3MvGzX0kEcoHg==
X-Received: by 2002:a05:6102:f9a:b0:467:6ca:b4ea with SMTP id e26-20020a0561020f9a00b0046706cab4eamr7415144vsv.27.1704219560840;
        Tue, 02 Jan 2024 10:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPp0hG5WfkeH0LzbjHWajPiAB+9qxqxdd6BihIJP6uy3Mm09c3D7x8kSQRjFEc/rxbGbMilzXbl6vnT7O0UpU=
X-Received: by 2002:a05:6102:f9a:b0:467:6ca:b4ea with SMTP id
 e26-20020a0561020f9a00b0046706cab4eamr7415124vsv.27.1704219560266; Tue, 02
 Jan 2024 10:19:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102133629.108405-1-frankja@linux.ibm.com>
In-Reply-To: <20240102133629.108405-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jan 2024 19:19:09 +0100
Message-ID: <CABgObfZYzBgtLVhqH+ADXM0kEkK9F_MK0jcjjhOPooSU1YQFHw@mail.gmail.com>
Subject: Re: [GIT PULL 0/4] KVM: s390: Changes for 6.8
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com, 
	cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, 
	seiden@linux.ibm.com, nsg@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 2:37=E2=80=AFPM Janosch Frank <frankja@linux.ibm.com=
> wrote:
>
> Dear Paolo,
>
> please pull the following changes for 6.8.
>
> The changes are fixes/cleanups that didn't require a fix pull and
> hence landed in next.
>
> -The uvdevice didn't return a firmware return value to
>  userspace. This didn't matter since that value was unused but might
>  be used in the future.
>
> -The stfle vsie code was not 100% spec compliant because it checked
>  for readability of an area that was larger than the one accessed by
>  firmware. Additionally there was an issue with a mask being applied
>  to early.
>
> The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b22=
63:
>
>   Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-6.8-1
>
> for you to fetch changes up to 10f7b1dcdfe05efcd26e90e337daf1bfd8f4a6da:
>
>   KVM: s390: cpu model: Use proper define for facility mask size (2023-12=
-23 10:41:09 +0100)
>
> ----------------------------------------------------------------
> - uvdevice fixed additional data return length (Steffen)
> - stfle (feature indication) vsie fixes and minor cleanup (Nina)
> ----------------------------------------------------------------

Pulled, thanks.

Paolo

