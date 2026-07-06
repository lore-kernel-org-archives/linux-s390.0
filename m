Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B63EFFA7
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783372378; cv=none; b=M0GritxMrqM2Ds7/3wSS1ofMGvkcp5zZ4omsT8DzzWK8Q3hcj8Wsf37/bmpcwj8MzYPnR7l44ahUyBmNunAZ5l9186Ju19bylkW5VlKyWdcqs7fVTbXfrwdZOQUgXPZfZmHuMFDpyBRctEAM9nZZiclTmpIQvNatBD1Nrv+d9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783372378; c=relaxed/simple;
	bh=pmu2Ns+u7j3MrvpRzE4vBrZuDK2pA+O79byFKdV4S24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a9kWnp5mvmRYgPY2fjKs3h6GXIaVcK9Glfl+6Z3gyjyoO0t2GRJeuNxqChpIBW98eJjYZHXgTWT3aaFrSCGx7XRouDEkMjxORUl9QBxkvbw8oB5VNKThqo9kmrjwFTS/kLB0Gz1ESXkEe3zgnzGfKv0bMjnmKrag2jpuYJzQ8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bw+WRFlM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bw+WRFlM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6a20348ceso48908335ad.1
        for <linux-s390@vger.kernel.org>; Mon, 06 Jul 2026 14:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783372376; x=1783977176; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7eGtWkkyAP+CX1fJ/+ZRWJr9u4Vfu7xwsEfOdR5rCGU=;
        b=bw+WRFlML1p3conawCJBm4Dl2JMJnF6Z9vLRy3QgwBv5ufs/IDLb+GH/cCnutkiSb0
         RFknGWJMl/lzn83Xw5yYHre1009HlOPgurdZsE1QADiuGoy+IvldLGtjR5iIr2PIH3c/
         h6rv2LyaqAu497ELhogixb2VSKBosMLAtkvswOyBYWVr7bG1LaCAUIWB0Z6MKhJNIo18
         OZ86fh9TvsA57LWng1eeT6pxlViETs0rkXZfwEMx1RmbTjJVfd7EvJLoRHaR9uq9GRU0
         gcUmrAHdZxtH/NSxjPQjkOB4dWkAOiPMW9xzF+sag/gJWfqVe+Twaw2xLQw4UcfLyfNy
         Zzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783372376; x=1783977176;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7eGtWkkyAP+CX1fJ/+ZRWJr9u4Vfu7xwsEfOdR5rCGU=;
        b=rNY9Z5lDob+yaIu7jBRMnb/OQoG47PWh1EP2iTNTgii3pZxJFYR/d2C79cE6OcIEiG
         bxPiG/Ap1QIFxf8L+ifQVHHD0MsauCeUS+jqBKFylIFZgBcevYqMN2Ifow5OFacCHcII
         ++UpLCsf4ib/24qCBIYIw3l3ptfZUtowchnxLwv3vBbeJPg5pnYleD7W4ErMtE5PMv4I
         lOZVwz3ozc5FRRdGpwyM+xM0Bq42Vcpkjua8H0TYOiOHk7s76JvF/yoiWqCzqOfNEosh
         /kLE1pafRYdWQAwYEL8Zo9WY/pE+2R3gnem2U1l2/DQXHiW/G6L/MePz/m65o0l3WIeG
         4iag==
X-Forwarded-Encrypted: i=1; AHgh+Rq2/cIT0SlWDVnBJ6ceVvZBLAxWsYmMiATMwqQWoGUNqYIlfgD19xEM0isbySHCXMZBCxIX1wyEq284@vger.kernel.org
X-Gm-Message-State: AOJu0YzJprYQXMyKTXb6eri5wigwOSDP/2BxsIXxrczE6jAUYu/7CMso
	FO/8z1dF67wFbHuB+pB/ktCueKrqN6Vh56a+kato9k054tT3p5j0z79lcf0Ny6VrEttrNxDlUSB
	DCqTACg==
X-Received: from plth5.prod.google.com ([2002:a17:902:7045:b0:2c8:903:9ae7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19cf:b0:2ca:bf8e:35fe
 with SMTP id d9443c01a7336-2ccbe611af8mr26055545ad.16.1783372375629; Mon, 06
 Jul 2026 14:12:55 -0700 (PDT)
Date: Mon, 6 Jul 2026 14:12:55 -0700
In-Reply-To: <20260706195313.GE118978@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706085229.979525-1-seiden@linux.ibm.com> <20260706085229.979525-2-seiden@linux.ibm.com>
 <20260706195313.GE118978@ziepe.ca>
Message-ID: <akwaVzghHzi8o8fK@google.com>
Subject: Re: [PATCH v4 01/27] VFIO: take reference to the KVM module
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Gautam Gala <ggala@linux.ibm.com>, 
	Hariharan Mari <hari55@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Hendrik Brueckner <brueckner@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 06, 2026, Jason Gunthorpe wrote:
> On Mon, Jul 06, 2026 at 10:52:01AM +0200, Steffen Eiden wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > VFIO is implicitly taking a reference to the KVM module between
> > vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
> > symbol_get and symbol_put.
> 
> I thought we weren't doing this approach? Use the struct file as the
> kvm handle. I thought I saw patches doing that already?

+1, my joking-but-serious NAK stands.

https://lore.kernel.org/all/adf29Rn7q9Db0hxc@google.com
