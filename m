Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8888443AB6
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514565; cv=none; b=Cu5WpqsQumE1fU8U4ifcaFvjk0uCD8vo3uCuvXkwdBfPsnLlFnxBdyeug8Ao9DdS3mv4KBX6hW3oKoFUyHGxhX2JvBFod24gO14p6tIpZt5j18MC427LUul7ieZT5FAjUFA6nUqigHQci2B20t5Jf0XD6Q85Ytk8yRRXl/JUc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514565; c=relaxed/simple;
	bh=/6OQz+DQUsZXcPRJ4R2zsd2kat4n8VozoJNKylE8h7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M0dRcreu5rkPgIgDa/0jL3fLBXpHPOOsoq5+v0CSEhRIWocilI5OSxBNl+/PSoSutXc0//YMYxdEOdSWg1M9QQMIIeqym69EG541bkocgXcopOFcLq+4ZjJjzvCWXwARCZDvFafW1IyHG04wP+FYG5Cfk2woNaj3j+8bNpBapiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kQFp2F52; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQFp2F52"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so21660955ad.3
        for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785514552; x=1786119352; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ytOyVvVUp1+iOjUCBAJJ+Zr5Yli10sJrrWCx9PaxhI=;
        b=kQFp2F52cW5DfoQqtvhhB2W1oDof3AeGU+CyYko3+1ZiI36LXPsJcSIbILKQzWojFx
         15xk68Krr2nmQMfbu7JDXQgSxl49Nj9sd8p0mTZ7LLvgSE10M7CXdbeWN8cdBIOz7UPH
         l7+sE0fRR66JG8lTxM2uVn7qYFFSjDd8twfsSin/iI2wJg53+5zmOtHGzrcTioUnnQf1
         ndZk8Q3vhzyW9lfKikWH4Af9K0LfNUffKtWf/za94enpuW4XRychccB9ClaoR1miZDiG
         wjcWbsY+qYtbIu9qCV5ArWX/86wChltRzaj7DIfpQ+dxKE90M9Zr64sh955fS/id+XUf
         EyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514553; x=1786119353;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ytOyVvVUp1+iOjUCBAJJ+Zr5Yli10sJrrWCx9PaxhI=;
        b=eXd14RArFuN13bb2lVNhHGgylfc0EZW8Ryn2TCyuL8emifhZir/4TIlLx5jCHBIh4I
         vUGN0ymDjp7QMEDxeMOAxflZWhoQrdeQAqMgBIGKJ3NOv3DO/xYPN6AK8U1kpd/QvS2H
         7e7q74NAnFsXxYyt4fqHVrEzi3vB2w3HQO71XnQJmkYHdl6EpAfxg5X8+M/mIV0eUK7p
         zy08xPtcv5CIoM7/0Q2/PcRH0gHwZASxel10uhMge7hQxmy2W39RcxR93Unq7qhiVqA6
         4ybKMugSgAkDEaC0+fxi0KnRYJ1DM1WwHAQtVwBXWHACCpVrvRLmCqoPrsK9dgsLFAAo
         hHtQ==
X-Forwarded-Encrypted: i=1; AHgh+Romx3cRIJ1Z3CDXVBlivEZY5qUtmbXRce3R0L2lb9EPdADO+EC7X+QV54Yph4eiNd1LSknIGDexhMUX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx7zdNz47XUtizKgGgAhSO3I4AprmEhVMZb0Bs/bc4ZlC6/+8L
	OvTJWQtFySXS8jjgMq9RvNMM1yuvnIpHkbVLiO6aZnftsPknQ/991Q480I51UnfoYGEtryZNmrq
	cTJRQgQ==
X-Received: from plbjg5.prod.google.com ([2002:a17:903:26c5:b0:2d0:40fa:a53d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2410:b0:2d0:4021:bb62
 with SMTP id d9443c01a7336-2d0521bcc4dmr5824855ad.16.1785514552447; Fri, 31
 Jul 2026 09:15:52 -0700 (PDT)
Date: Fri, 31 Jul 2026 09:15:51 -0700
In-Reply-To: <20260731145435.1016137-B-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731130902.654679-1-seiden@linux.ibm.com> <20260731130902.654679-2-seiden@linux.ibm.com>
 <20260731145435.1016137-B-seiden@linux.ibm.com>
Message-ID: <amzKNzYWD1ngXdOZ@google.com>
Subject: Re: [PATCH v5 01/31] vfio: Use file-based reference counting for KVM
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 31, 2026, Steffen Eiden wrote:
> On Fri, Jul 31, 2026 at 03:08:29PM +0200, Steffen Eiden wrote:
> > Replace manual module reference counting with file-based reference
> > counting for KVM integration. Previously, VFIO used symbol_get() to
> > obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
> > then manually tracked module references through these symbols. This
> > approach required storing the put_kvm function pointer in each device
> > and carefully managing symbol references.
> > 
> > Pass struct file pointers instead of struct kvm pointers throughout the
> > VFIO-KVM interface. This leverages the kernel's existing file reference
> > counting mechanism via get_file_active() and fput(), eliminating the
> > need for manual module reference tracking. The file->private_data field
> > provides access to the underlying struct kvm when needed.
> > 
> > This simplifies the code and removes all remaining externally exported
> > symbols for KVM, paving the path for a second concurrent KVM module.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/x86/include/asm/kvm_page_track.h |  8 ++---
> >  arch/x86/kvm/Makefile                 |  3 --
> >  arch/x86/kvm/mmu/page_track.c         | 16 +++++----
> >  drivers/s390/crypto/vfio_ap_ops.c     | 24 ++++++++++---
> >  drivers/vfio/group.c                  |  2 +-
> >  drivers/vfio/pci/vfio_pci_zdev.c      |  7 +++-
> >  drivers/vfio/vfio.h                   | 10 +++---
> >  drivers/vfio/vfio_main.c              | 49 ++++++---------------------
> >  include/linux/kvm_host.h              |  2 ++
> >  include/linux/vfio.h                  |  4 +--
> >  virt/kvm/kvm_main.c                   | 23 ++++++++++---
> >  virt/kvm/vfio.c                       |  8 ++---
> >  12 files changed, 81 insertions(+), 75 deletions(-)
> 
> @sean: This is based on your draft in https://lore.kernel.org/all/adkFk3ZN4HJtpLA3@google.com/
> do you want another/more attribution? 

No preference.  Do whatever feels right to you, you'll know better than me how
much of the final code came from me.  If you want to give me a Co-developed-by,
here's my:

  Signed-off-by: Sean Christopherson <seanjc@google.com>
