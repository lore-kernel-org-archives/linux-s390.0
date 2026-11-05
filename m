Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840563;
	b=WNm09iGDZYIczqss0k0T4E/bvWMiZD9KaHr0kjACKxyo2/Kzb6STffXRED2WdBGX0eAP
	 6ZJRQwJULvGswBIEpjr6hq44R053awUAscSpKWSwVFNj/udiKbZgL6DjRWORNBliQ/Q6l
	 w++7JH3FCrntdke9N80/KEHHVoRmfyY5Pp4jqigsHC9WjqUWBxbLawzMCObzfMG/jVbsT
	 Wx30NAkdbsNjcmF+/jFlEk1mBb3PO1MqNmylF/SpUGmkoGCmxdS6kAm9k6XvuBwAHv0XH
	 zvwxIbO47fqBXDMfQ0tJwU17QiqcjeyhHGXlgtlW2Gdl/UyGbg8XR3EJbLqxS339HSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pd5083dr9bSH8n1jTMbA4i3mKvFPliz6jrMQ78aFKC8=;
	b=P5iggpItpybJ+pCS0DqIWWvrY9+W1zoMipymL81zmk4mdrlQcQAzO2o6EDpS9K0KkTOZ
	 N4Ahy3V4ZA4k4EdUvH2UKZyJfw95w4tqPbzCizApAOt+8pcQFZFV0ABwHVR8UeSPs0sRw
	 S8MC6rysVavFlroVxOVKgpJ0pKGMxtcecxeANZndsgheVBsesBE0PZnGN5hdXipewnfkV
	 9Uf/A+SWEnsd/T5EhqY0Bp0CMbbkJABKKYjPNDusR7yWUTvtJ82EExIt6dc0i4qx6l0vU
	 MP7VVVUi6a3qzxgESl+gdQb6ldDtFQj7S2Nc1enw92zQ+XL63C435swCfU3C7M82JEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="BMeV0/oU";
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56255606A330
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 01:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56255606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BMeV0/oU
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdacb64970bso716459a12.1
        for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2026 17:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793840563; x=1794445363; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pd5083dr9bSH8n1jTMbA4i3mKvFPliz6jrMQ78aFKC8=;
        b=BMeV0/oUgEUf1H0pqva9tSc+R1u6PArFg284CPniJAINpcFl5+ulnnJz8cOLttLvQQ
         jBW0Y2K4f92054y1Ad/Y0DcHpUJaWctqJRKH/VyJiuGVVAn2+vyLulpigfvSclMLvY8F
         HouyS3B4WDpuTPe2oqWykeQKYiw1qqZexIKfviXBs82zhtGM4c3iF5tCtvi0Rr2Jeft5
         KpDm9PMTH3xvtmhOfTlA7AzH/wu5mFcIOoYgpsCX3XH+C4tWz3cEyW704ibMvwMW22cq
         Rc3t2R8VnHXO2zHsM+NnG3oI+QlrrAK/j/zfP4v494gNz4OoR0cscy6PyCK9SqeKuxsk
         9rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793840563; x=1794445363;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pd5083dr9bSH8n1jTMbA4i3mKvFPliz6jrMQ78aFKC8=;
        b=l92juJipI20pYULWVApTDBhC/NTrGsEspyaaOxM9TUSWR0A8+DnFJaAfpObVB6YZxq
         5R6l6r9zs2mqygj8V98gpBVSNiDpZkYh9L4ReZEa9pfrFYkDRhmkNd7RISx/Oodu3sWc
         N9eDENTJfMkKpa4i/7c94u0gF/1gQacKMi1ZcD74AcAt5wLYbULFNuVraLIsm/sn507X
         KHIHRpcoiXPOBBYIkBhNTn2tGfdwa2DUx6t5DwCtFiteVNXnT6ddYR1/S4RxDgwi6IE5
         iUz0x3EX9fqJ6Px7ij7/VLynbPwnpMQqX/cpebOwhHgbvPDZPvyvIinDoRohJQI8Dono
         Xy8A==
X-Forwarded-Encrypted: i=1; AKwUvBxtkixn77pU7WwQ1OHQ82u5ftDMLklL6gt/oRxcrIOB1+VpdNY0hvWjAroBfWyLol3Icvq28usRKB/W@vger.kernel.org
X-Gm-Message-State: APuU4Z8eyuNBBNi1tj8Hw9TMqu/txk/nrTowzBHcayAwHuKkAy+VFGFs
	iEftw7BmpdEuiOP1OxYfSPgh6YVqETI11/qjW6xTWnF/D6ccp+L5ot0AVVDloKfpxed/tIDMC0f
	tpB6/eA==
X-Received: from pglk7-n1.prod.google.com ([2002:a05:6a02:6b87:10b0:cd6:b725:c290])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a08:b0:3e2:6e7a:bc13
 with SMTP id adf61e73a8af0-3e928abd4eamr15851564637.79.1793840562345; Wed, 04
 Nov 2026 17:02:42 -0800 (PST)
Date: Wed, 4 Nov 2026 17:02:41 -0800
In-Reply-To: <421ebe63-dd9a-4da6-a2f6-104a9473b301@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <50a3ff35-ae53-4372-a53c-c07f1d153627@linux.ibm.com>
 <20261023140506.336663-1-borntraeger@linux.ibm.com> <att35ilyLvAA8gM4@google.com>
 <421ebe63-dd9a-4da6-a2f6-104a9473b301@linux.ibm.com>
Message-ID: <auvVsbpFq4vApW1H@google.com>
Subject: Re: [PATCH v3 2/2] KVM: selftests: Test that KVM_RUN fails for
 unresolvable host faults
From: Sean Christopherson <seanjc@google.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 27, 2026, Christian Borntraeger wrote:
> Am 23.10.26 um 17:06 schrieb Sean Christopherson:
> > On Fri, Oct 23, 2026, Christian Borntraeger wrote:
> > > Add a test in which the guest writes to a shmem-backed memslot beyond
> > > the end of the file.  KVM_RUN must fail with -EFAULT.
> > > 
> > > On x86 the guest enables interrupts, and on s390 the test sets up
> > > pfault, so that KVM could handle the fault with an asynchronous page
> > > fault.  If KVM mistakes the error for a fault that needs I/O, the vCPU
> > > retries the access forever, and the test fails after a timeout.
> > > 
> > > The test is not built for LoongArch, which handles a failed mapping as
> > > an MMIO access.
> > > 
> > > Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> > > ---
> > > I went with Seans name proposal
> > 
> > Aww, bummer.  If you posted a faulty_mcfault_face_test, I would absolutely apply
> > that and force Paolo to tell me no :-)
> 
> Sean,
> Will you pick up the fix and the selftest, shall I do it or Paolo directly?

I can grab 'em.  Were you hoping to get the fix into 7.4?  It doesn't seem super
urgent?  I was leaning towards waiting for 7.5, but tagging it for stable@.  I.e.
give ourselves a full cycle to make sure we didn't miss something, then get the
fix backported because I wouldn't be surprised if people are hitting this in
production without realizing it.
