Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418F937CD39
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557724; cv=pass; b=i9U6vYEYa/9BNapwlPimXF34haPQqRghc2UCQBSS8xa1mcnBLzuTgxsS86apoIaaT19Brdx4jRtp8E6NT5mxAXqmwpfbG1NgL936hSJJi1OI01qlnPgos2yTn4x/5T4Qg6YlqReuhMQCrdgrNB97p59wHy01ufC+QGVeLrKr8XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557724; c=relaxed/simple;
	bh=6meBRs5nEnzEznihvbKKzPhzXCt5ZLXtMWNzXDh/Pz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZ4SzgL2b1JbBca82TSfSeLnes4hALumgW2uNYNC5F2GloQGsobZFkt3Ll8BUisBAEbZQ2dAkVcsFfOeQpwtdDsPW7s949vKcIHzKd6Q0/Zxgq010XHzJUCBJKO/mqFRogmOZq6cl86ZPrbLUnKGPKwobvofjXksFi91ATGF3Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fMDhVnQM; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMDhVnQM"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-beb7f26ed62so39760066b.0
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 00:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780557722; cv=none;
        d=google.com; s=arc-20240605;
        b=gEYvhIUt0cPEzzbqY7tV+Zdrfefz96c+0Y31zvvEs5yWkg3MWButComzAMIwp9KrKh
         wu8FKdfreNl2U47crQREdFzjl1OtsZIXDtxRJwM+feYcM6+SOn8XeXOOFcKWMtrzYgJN
         cgmg0kBsE1+nJcDu9Els+l+0hao5RzzdyrWirfhyJ6NNidi0TGA4yREnJROMwCVfS3pu
         tOgcl03alXu3/gTHBiRrixykdYI4DQUrpEdj/s8Z+BYao8rHJyMsfZHOqPMCURt3RpJg
         pOX8USnDNH4m96SATtcBK8Ui6XPZ53CYjwDr1rQ4EYuQ7PH1qsIyxPCy2XJVRELeFptZ
         m+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lrvkDQfBnoMGYCzLOCiivKkoiHfHm/OTQW0RCIfHRHg=;
        fh=9GPhguT6jRVMkKXlymlx6MX4h6AdnNzdR+r6EoFWP5U=;
        b=JIhCWHVNww1AJw3DXGpk5/ftDJqNapQvswcKp8/xANxGuEOuycDVdf56F/7k4dy5dy
         CiOjGEWBpHorETTV4s6pBsWyS2/tBze+C2ha+9RVCDhdF1Jb9nQ/vrdKb6dFuvunnm0S
         csPUa+PfqKBPRZY89rK5LXuS2yyzCTFGd0Z/OnB6y/1FctJ314bGN1Px74Vb7O795JMg
         O3Zzevu0XxOY87QN21m75msxzH5AI+rU/lQOmWlAJNBy1yX5ACIVe0cjL+hymHQvGCUM
         Cy3qfG6UchbN12xak6nRIsCkl0pnoIDNfg4hkIFtfVEc8Sl91AONE8keKJW9Ye1bJyxl
         ydJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780557722; x=1781162522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lrvkDQfBnoMGYCzLOCiivKkoiHfHm/OTQW0RCIfHRHg=;
        b=fMDhVnQMcKxGvnaf1Y7Bj4SNxOsGGb1K+X10rbRISykHQV7XOK2+6otVL/Hs88eKaQ
         du8IQgRES1UUvRDZ3Ed6/imEXR66+NiKDlM1uTHuHLa8YBxiOyOw2hIFXrSNTwpE3d4o
         eysGZMNTVcj32swCsL0iK86aLPUsA1/IVUW4YxSIg5MItQXFXaDt9RDXYoSiuZa8pCwo
         3R/g5H0iTnxuwW9t+d0AIJBsEKp+9C7mRvmW77AWcLOHksmuXPDyOR1AQxE1PNHu1EgH
         kGoyNdcDudVWzi+nIihKlIFMQyFYyowp5QKVdo7V0aApn0KCcDiplz5/NEb285DAqgej
         Imyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780557722; x=1781162522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrvkDQfBnoMGYCzLOCiivKkoiHfHm/OTQW0RCIfHRHg=;
        b=bOeyP0xDV8Lrc0ZPChKVNEugBOrjMC6NRQx6Gn+M0jLfQtR+HHJKh+4zWCcDC2vB62
         dkdFUZYy0/5Ceep0A2hUEpZ4DDCOAT9WoG/Mm7Dkib0w06cin9choLZ7ON7FG2aXhpEJ
         KRC+Rykde2I2f+ZxA5Z13jj4+WD2KwqFEKtgcDRnaiyZoEH707R4eC21p7iwUqfxALKP
         XlarCTcUX0difGVgFmfCsfdWGkCuf0lQS4ryFHW6VUGBpYcpt8VZju1aZdK9WNnACtYY
         Bi/VDTeVz8DaQX4jn+5ue/0RaqGSbHk8wZCSXzOXxSJ5sQoz0bw03BWVmupluW9bxN4k
         6pgg==
X-Forwarded-Encrypted: i=1; AFNElJ8kordy5bQO0Ps/HiEhLg7fZqb6RN1W2pss4DWRqV5IgXDmwCCWYQJOMo/p/LKB+L2c7DmWZm3LgjFt@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkrpuU0Q7PBAfm3QKmNqPYd1RPEKVBE7kVBgrRAM96eN3a0ZG
	rWGC1BqtnrqbhokkQeYBdXOBdZFLjexN/cZWlWPpNSqJzuAM0eEKrDPwQja9AapFXtrE6NMam0G
	Q81GFaTPj8jjGZ5jh4Qdrqt7vmNJL89o92mNeuoOVmw==
X-Gm-Gg: Acq92OEefUrRBm12yFq1t4/LoQvjb7vKGAAmV8AO4aaBYfOkfNuqxcHEhwt7lUk/Mj8
	rEt8oZHGVsNcwb2OYOdjxY4dU9SFLcd/QQd+v1RS1hTQ6Rdfu6BN7bmvSuqaAXWwNzIASXgfMtZ
	WsvjlsjcyupCD73NIGrrgyrWOU5llY1gwajWeEvBbSpR9/UUaHMIDFe3GMtcYNoPlxMGUuSYTu2
	4pykAsQPc6NJhpcoe49Fl4aNBRr3aMd0aCh8+ui4q2TLe+cDKXWGeFw2wL1KkLymME/10A/tjt2
	djOdeuAQBAepFenKFHpuvYRxEjtdOMtXMuN5q0C/Q9UbK2UKzQ==
X-Received: by 2002:a17:907:cb89:b0:bee:45f5:3e with SMTP id
 a640c23a62f3a-bf0b4395beemr416640866b.47.1780557721718; Thu, 04 Jun 2026
 00:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522225853.878411-1-tjmercier@google.com> <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca> <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
In-Reply-To: <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 4 Jun 2026 12:51:49 +0530
X-Gm-Features: AVHnY4LN7rgVW4AsJ6ueOLy3-gj_m35-QjBHqySb09IN1JOBtBY4T1wqgFsSviE
Message-ID: <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
To: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@infradead.org>, 
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	lkp@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mm@kvack.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Thu, 4 Jun 2026 at 11:04, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Wed, May 27, 2026 at 01:07:16PM -0300, Jason Gunthorpe wrote:
> > On Sun, May 24, 2026 at 11:21:33PM -0700, Christoph Hellwig wrote:
> > > On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> > > > After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> > > > module") the system dma-buf heaps can be built as a module. The
> > > > system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> > > > but those functions are not exported on powerpc. This can result in a
> > > > build error like:
> > >
> > > I'd much rather revert the above commit.  Yes, x86 has exported these
> > > since 2017, but that's a really bad idea, and we should fix it instead
> > > of spreading the export.
> > >
> > > Setting memory decrypted is a dangerous operations and should only
> > > be available to core code.  We should have various allocators for
> > > decrypted code, but not export the functionality to random code.
> >
> > At the very least an EXPORT_SYMBOL_NS.
> >
> > Looks like there are about 3 modules using it already..
>
> So, I'm not really sure how to fix this now. Should we revert the patch
> making the system heap a module, or should we export the symbols for all
> archs?

Given that Christoph's objection is not really about the modules part,
but that the set_memory_{encrypted,decrypted} should not be used here,
one option is to revert 78b30c50a7ac until that issue is sorted out?

Jiri, any thoughts from you?
>
> Maxime

Best,
Sumit.
