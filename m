Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D32DCBE6
	for <linux-s390@vger.kernel.org>; Wed, 30 Jul 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899515; cv=none; b=jQiTT2jMMJEMH31vdkQMWcMdEASfQBxkoVtYeF0dda3JRSUfuULlS0P/vJmIBMJ/PqODZvAeZrDhWvTu9FQb64/FAWfhAN+Z0Xs5DPG93l1RnSXzQm3Oaz917zbUPr4qrqrflRlME4h6Zhmb4n/ZXwV3nCx1zLOopdHQ3Iu1vaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899515; c=relaxed/simple;
	bh=PsagS+IE7if1V/PWMVYVqHDLKHmjmIfs35jLXauMLUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX4WELkMRd+MpcZXfOtp+cB2+7lDPZ8caFRRmzcHvnUwEN5rU9s6O+W+Y8yjBsjpsT5PdnMS/aAbC52IdluuioSuAs9DYY7XW5FYM136PWm4xjojYtjhqNXJ9UMmIdC96I1fUeg1xSYEs4jhMsKCumbBYsVDn+/q1ey2X+PA6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QT5FnN1Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QT5FnN1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753899512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4QWYQtgd35SUXwv/GhDznjCpbjlsqIUrj9SzEG/myA=;
	b=QT5FnN1Yn3CbRQz7t1kNGQN3oEt7i9asyI4ZG2Vu+VlOIdrfPk3t25JwM261mRyZTAMYMT
	nYAfj2hkvr7BWHWnbufFhp/RuQixWe+VGZ9i+aMGIT6ZqUxxrTRejYnL73GdAicfOlaBXt
	gJYkdOhj5sv4UWAeEWnxsVvvMN9lE8U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-Ia2TGNY8MwSctJsiHafL0A-1; Wed, 30 Jul 2025 14:18:30 -0400
X-MC-Unique: Ia2TGNY8MwSctJsiHafL0A-1
X-Mimecast-MFC-AGG-ID: Ia2TGNY8MwSctJsiHafL0A_1753899510
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7931d3d76so65530f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 30 Jul 2025 11:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753899509; x=1754504309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4QWYQtgd35SUXwv/GhDznjCpbjlsqIUrj9SzEG/myA=;
        b=DP+AtK+6H7oaeM6KobQc99CTY/p63nl7pRsDlEnRLw9I2S4DBcRElemIExUsiq1wXf
         j2JK3gm6ZPcOfrC2Y3VQP3syIZjqTled+5fOKKR7MD0L6GX9wm1Wti2Lzza9bmL3W33/
         t96qPMK/mHyhWkMfuwyaAVKCWOxkPr5C7cqY/4si/+ICY++lcKWAI8KnR7GsK1j6Ji53
         MKLCx4KGXWKWQ/XNFzXSs+dcM87J5lHKMLBoSaYg9kv/ebJm5VqQQNXI3aHzSegKMCtt
         cDiIAj5F9KaJUyh62PhLW1JPhaZ4AghyiebkQryRLntgyWu4XyNBo4m9asvLL76+XplA
         pfuw==
X-Forwarded-Encrypted: i=1; AJvYcCUPMOqUPt3HO0CFnmwzh9SKpaltizaSZg9iM7dAdpJv0f2AEIujoeN7tWb995puavUaMpL5S+vixi5K@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10QTj0RGjbLWQsQ2+xd2wkdYn86w/bYyngDsYNVFN9WvS3HRR
	9WZkCsJZyEDE4ijjPc2AN3KiIMnilr79nHH5wyb2aoSAPyVpYG6Iyhh4/Dwmi3RFBDjfB/RrYDu
	Q8oOsDoHFtoWQsKiqxzy5/d1isswaMaJzek3sHEIpRE04v72c/HsvbO47bIA5FgIgCxaSJ+xuo1
	mSKBiKAp3TZF3qsQCGiFRG3lXejsUA6gavZtLkXQ==
X-Gm-Gg: ASbGncuegKhP6+yGpmS/fvsPJMSmiucQ8f/K7im4EoExtrzeWJB64IkwnCTYz7T0zLs
	aGGHd12wbA5gJg7arYqFEapv2X4vsFxgB1q0+HnNEGTBsA0w26US9JreSeJjxxX8NUrJVX/RbUE
	kLgSBDmXONkiMqMSy24XfKRg==
X-Received: by 2002:a05:6000:1372:b0:3b7:994b:8438 with SMTP id ffacd0b85a97d-3b7994b866dmr1400870f8f.46.1753899509606;
        Wed, 30 Jul 2025 11:18:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG25KUZVR+QLXARIK8z31ni93AUxeR9b6roUWO0z4gqYEZZLbDSFN3lqPAYFZh9lzCVKHrXGvQaGRTgYMUrS58=
X-Received: by 2002:a05:6000:1372:b0:3b7:994b:8438 with SMTP id
 ffacd0b85a97d-3b7994b866dmr1400856f8f.46.1753899509188; Wed, 30 Jul 2025
 11:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730081224.38778-1-frankja@linux.ibm.com>
In-Reply-To: <20250730081224.38778-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 30 Jul 2025 20:18:17 +0200
X-Gm-Features: Ac12FXzAtwkyRuWgVqkSS92XfGHy7DPMFIKF7LmFi_UY11OBXLoweByL7G-vdKw
Message-ID: <CABgObfYEdwFb+dpDbKF6U+tMFO0vZJVbQ=8=puYAp9dvpm-K0g@mail.gmail.com>
Subject: Re: [GIT PULL 0/2] KVM: s390: updates for 6.17
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, borntraeger@linux.ibm.com, linux-s390@vger.kernel.org, 
	imbrenda@linux.ibm.com, ajd@linux.ibm.com, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 10:13=E2=80=AFAM Janosch Frank <frankja@linux.ibm.c=
om> wrote:
>
> Paolo,
>
> here are two fix patches that cleanup s390 guest entry.
> They've been part of our CI runs for a couple of weeks now.
>
> These patches went through a couple of hands before hitting our next bran=
ch [1].
> Additionally Stephen found and fixed a merge conflict with
> a70e9f647f50 ("entry: Split generic entry into generic exception and sysc=
all entry")[2]
>
> Please pull.

Done, thanks. Linus has already pulled the tip tree, so I've described
Stephen's fix in my own pull request.

Paolo

> Cheers,
> Janosch
>
> ---
>
> The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e326=
7e:
>
>   Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-6.17-1
>
> for you to fetch changes up to 57d88f02eb4449d96dfee3af4b7cd4287998bdbd:
>
>   KVM: s390: Rework guest entry logic (2025-07-21 13:01:03 +0000)
>
> ---
>
> [1] https://lore.kernel.org/linux-s390/20250708092742.104309-1-ajd@linux.=
ibm.com/
> [2] https://lore.kernel.org/linux-next/20250729105655.286c0496@canb.auug.=
org.au/
>
> ---
>
> Mark Rutland (2):
>   entry: Add arch_in_rcu_eqs()
>   KVM: s390: Rework guest entry logic
>
>  arch/s390/include/asm/entry-common.h | 10 ++++++
>  arch/s390/include/asm/kvm_host.h     |  3 ++
>  arch/s390/kvm/kvm-s390.c             | 51 +++++++++++++++++++++-------
>  arch/s390/kvm/vsie.c                 | 17 ++++------
>  include/linux/entry-common.h         | 16 +++++++++
>  kernel/entry/common.c                |  3 +-
>  6 files changed, 77 insertions(+), 23 deletions(-)
>
> --
> 2.50.1
>

