Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1FF42F6F8
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317321; cv=none; b=E+z9PbrrVlE9K4S06Wf2pGFoXDjxsTLX314EnkcdXIbgNLdEYCLxvadG3gUwiFTh8gge6RJOwsFp1VHFXG57r0otrP/nCaXfU5nmIHnqb+uy//XH0l4cOHHeBYUeJBg2nKLsKadAMlnqRMYECtccXh5URtgW6SsP6hAEehfsr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317321; c=relaxed/simple;
	bh=UjlgwLbgeh6LAkjBfXyoi1ibUIo+DP0JvbI95ZXgWUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr4Ye9XboH1LyMFzNOJnPj/VcS4scLzYCdHwh9aI7HYq1x0WXhzOvcfGY1rCqRME8d0mFTX6144jO5iEKIZ0pIQZvUz4VlhoQDSoPsmqGlW6ihB5UBE6mmbz/baJhOkHm56qcd+veTcK4WIotTaILUygTK3kUID1lBPGZOa001k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcCf+rsu; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcCf+rsu"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-3396cec93b6so558672eec.3
        for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 23:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790317315; x=1790922115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=peRJubAzt5CBA3DlGa/amJu9ZBZekocmcGMZ2nqjKzw=;
        b=bcCf+rsunlWa3cL2fTN0lmKtabtaSpPf9CxG//dRhkFwqKSBHmPh967KVU4dyqW1hN
         S+/MJMVAB1rpNZoPph0y3i2MyKehfWzmrTciN/9X7GyjTC3G3qFiS97oSwBjslTgHMYq
         tmdaWhiSdVVS/AKfY08MUrFsAyT25NpHMbf1mJPnOz7p8U3XeWuQnUAcRBfvPCy5NZQW
         qbPv7bHikYGOXqI0CUjwHojlXG1gyAMH+f534exx2k3rwJyYgROCOd9ckPhz/osiV2iL
         p7JGh1BHpSZ0MhpX/gwlU+TYbI9HoE1RDRM/kKCvvKIM+yyRaYEMTsmkrcJyvcuCei8p
         86dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790317315; x=1790922115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=peRJubAzt5CBA3DlGa/amJu9ZBZekocmcGMZ2nqjKzw=;
        b=qzce790F9w7oMO3ok0AIU2/Ky71aQ7J7F9Pq8ZCWSBRn9jlCUZxe7BrwHxQsvLhe/l
         7CVcmTGOqbbNLo8cOnPUHPTchzPnKKcK/DIbWqphDvYYgUxsi5ogY07ChHoTKQ8v/PAM
         QY6pUOzjmL4VmWlGIeQUnD90Uzb3teFvkZOuQTnjR14acL4K5HQlzGuUmuIh5DvF2NPD
         aJwOV5BIRYhZjadlOfUNuVYg9vRBYeCgygh4SyesECtfWJCv6Gx+JLlWH663/KKQl8di
         hx3T6ow9AkonKyzn7btcZJJp/d8rZ8YKUbl52EOxSd0DwNhYfftqHroEy/0AdNv/K3cK
         SgFw==
X-Forwarded-Encrypted: i=1; AKwUvBwlFaSJReotcUo864zJqhhlnsHB9P1AimHSGTLreVtENwsG8mLeA8LP3owNDYkFCgARZgw3oX3zWvmL@vger.kernel.org
X-Gm-Message-State: AFuF++nvwTP3ln/cpDkqJ+bYgq7APj21bTNgQpRDNkv0mG1szd1C2Mwo
	lHVlx1oW2IUCI5EGyo9D8Ctm4HCeB4PdxaVqr9zc2aikmamzTlu9TWEr
X-Gm-Gg: AYBFou0WlMLsise5NqwjzHgNxisqCASJiLHbjou7niZWAbIKMy2F/19A5JJLxglALmy
	bjvKv5thwM2tQT/TaSrzhElXJRNer4cpV1LR3DKc/6SZ5CoQIYaaoP44nM1/Mt6OjrrQpzlJ2XC
	aGkeN/EzHuLDbox3pQiIGYmqVTFB5n/nNvMEAJL4wU7aDexhmnNLcxxHfSyXvS6rElupAaEGw5Z
	BEmf/T61P/i4WkXucsItJJYU0yUVa+EXgKrZ6/y4jPcmLgHYOgPr06XJet7ErUC/+9SaboOlaS9
	k/op/pvSOBC+HvMA4DemZML5lkQ3bQk++7b9kH1/vG8zKDsGEEtj1j/b0HkZ9I405H7kFNL2jhL
	Mj/TQs/7jwb3/D1IVhKDz9xR3FhwuuAryIvrk7H73pyHVzfGBZ/atddI+RZduxwWnyzATyyI3rw
	G9U3bA8a4hkuGzPEJ1/Yd73ibctze/93SfOzyCvAA1pCAzZ+01/mv6JAYuiY8y3rTa21AqSEPSx
	BNodNIYAfESwPCD4RjAsii2+y/HjilVVhVQyWVZv6a7
X-Received: by 2002:a05:7300:dd47:b0:342:94b:aa28 with SMTP id 5a478bee46e88-342095b08cemr188044eec.27.1790317315073;
        Thu, 24 Sep 2026 23:21:55 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172de6sm5598126eec.9.2026.09.24.23.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:21:54 -0700 (PDT)
Date: Fri, 25 Sep 2026 11:51:33 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, 
	sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, jszhang@kernel.org, japo@linux.ibm.com, 
	peterz@infradead.org, jpoimboe@kernel.org, seanjc@google.com, pmladek@suse.com, 
	thuth@redhat.com, ynorov@nvidia.com, joelagnelf@nvidia.com, david@davidgow.net, 
	fujita.tomonori@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <arYR4GrzNnFko7XO@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <arUYLsJJewE--wqo@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arUYLsJJewE--wqo@J2N7QTR9R3>

On Thu, Sep 24, 2026 at 01:31:42PM +0100, Mark Rutland wrote:
> On Tue, Sep 22, 2026 at 11:20:00AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> > bug_addr displacement — i.e. the arch's trap label reference resolves to
> > the trap instruction — by calling find_bug() with the exact virtual address
> > of the trap, mirroring what the real trap handler does.
> > 
> > To support all architectures, each arch that implements ARCH_WARN_ASM now
> > defines ARCH_WARN_ASM_TRAP_LABEL, a string constant naming the local label
> > at which the trap instruction is placed:
> > 
> >   x86       "1"     (ud2 at label 1:)
> >   powerpc   "1"     (twi at label 1:)
> >   riscv     "1"     (ebreak at label 1:)
> >   arm64     "14471" (brk placed at 14471: by __BUG_ENTRY_END)
> >   s390      "0"     (mc at label 0:)
> 
> I'm not a fan of exposing such a low-level implementation detail out of
> the architecture code, and I don't think we should expose this.
> 
> What exactly are you trying to verify here, and why? Has there been
> some _specific_ issue on powerpc that caused you to look at this?
> 
> Mark.

Hey Mark,

During implementing ARCH_WARN_ASM for rust I broke the bug entry for
powerpc so I wrote this to verify. I sent it out mainly for ppc but
few people wanted that if it needed it should be done for all archs.
So separated this thing and sent it out as an RFC to check whether
other archs want this or not.

Regards,
Mukesh
