Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B6A385D86
	for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383187; cv=pass; b=uobaKMnjefvxjYVX27L4kL3gefT3BGTAWBo23FCfObiIVyUZDIiGnJGKD8IXnD0vUy66wsWkjtimR9kY47y2Q8HNaLomFKNXgJe0jvCSX15nsQN8raS47k3TaZXwrTJ7pjUvZK5RW7XY4A9FNWUpAmPgP9Yc+6z3VIksAt2zvZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383187; c=relaxed/simple;
	bh=6ScDZWa+hTLOkHKii79L+YYLthbYhtQWZThvRzyqBN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BU3ewXSJ5tXSMZCERWgtqywp/RuWt6GXnm5H9Tq0H0TAFlk8vxxaW0CGHnlwAqM4yyRQ2O7hOjL01q6e90Je4S67KXLj81MGR8PiGAqE5Cs9vn7eRFp/Kc6Q/x3A9RHnDdb+SyIGPkPFLeRbhjkLgDeJUW5e9/YbfK9yvxkI8Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEcrmZCe; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEcrmZCe"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e61648f10so15601cf.1
        for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 10:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779383185; cv=none;
        d=google.com; s=arc-20240605;
        b=H/+XeBhbvVjRdddNX+8imY8yFjT432ftDFec0d69k2/rQw1LvrpqYBjdRcLu5Ctlvk
         TaMOpGm9iHyYROvs0rcC4hwpX2vt9bdC14GcuUUK3+yADapVnxwN3zI+hKi5TLrjiKZD
         V0gpPV8aAfB3nr+XIZOwsHIsOJWmUJzBtutsBtGvqBq5E4+ePOCneoQdeYTFsA2ajfuc
         UJFdylI1JMZXVquBIsB8w35+NsHSIEVXd7u5cC4Njk3AQM0SErRfdLoSMaAkvRfZnaHg
         9p++Ddz9W8EOG343UO08SqlKlXYrp6DhMCQHuU4SklraQqCyVZoIrUuwssWBwsp4N7ZS
         CIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhUoyYsFnF9za8i7wBF/DE6TJUENWY+2L07rfya+Q9g=;
        fh=b9EsR6ugSnwX8P3IxyjI4KmZTxOywWCWvtZCg11i94M=;
        b=du1olf27q/kS6H8v7enW1D9YFa/67kTFQlSqfms4nMDriB2b2hoJ66z05TKmFK4sFu
         4uxi7fgj4jN/G4LvBU2f3MSo07GjxAV162fFyL1HhBnoVb0xTTGlWZuhH8pI4Gm/az4c
         stC0w5JkziFy5q8vmDvS/3KhKp2GPA91hVbM1RT5ksV7LCPZSBs516i+Itzn6gX8quFd
         9VIIsUfqN5wBC40q4iI3aFwyMpfBS+Ms4UFEv4mFv3NCMKbeIe5lLr8iCPkGamcHFF1F
         Iw8NiosR16wbJDaVi4ycO+SdCr5opV3wYnZv+r7EOE5B0ElFuUcp8bxC7olOi1/uJSp5
         kvAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779383185; x=1779987985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhUoyYsFnF9za8i7wBF/DE6TJUENWY+2L07rfya+Q9g=;
        b=ZEcrmZCerqBnOOk62Jl/NRweklZgf9YR4rS7NcLMmQFjiAsyJY0cRI1d0XHrT/brz+
         8dbwHTp6Ggt9je2MfsPetLB7iU2ZBPJqoDW0Y1nIlbpo9kGfRJjY0nGprkKujB0Zrbnx
         VqdZhhRr3we3a95rdN/RkFWrF7Fd9Xktk1M/qP5tV75FOo5IqIh8YRsVZ1CfL30iNEJA
         rtY7QblvSUf0ATX/f2qEnJCHvavdClAz6hV84PK4gRkDNu597vYqA83Gmv/jjKy1Fr82
         EJWqVyLGmCAuwszD1gM3MN6fOTtSnJn6Ze9MgyIzGqsySLZflBkMyjoHxl01wCH7Udd3
         5rAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779383185; x=1779987985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhUoyYsFnF9za8i7wBF/DE6TJUENWY+2L07rfya+Q9g=;
        b=Do6sSjjrWgaUXMGQGYN4LyoPPLUONjG4/zRx5uNO/sK8DY0XIcz/zZ0Qg2pWhwiHnv
         RXP5+Ym28utvXopXQbsewhP1HpjAurtvl8JWDL1QLgEk3gzqTH5X63QMEGZK3g0wsdK3
         D9hQhkWIVHXcBs/oCZ1aqbbsjlt5/v3eNX/YsiDaPo4QSDWZ29Qr/iZOiYVoaBioZNS3
         v47sbPk2ZROz44YQvwm71eFi8yxXM4v2a4jjDIRG/bM7mCmCVyxZl1L1J7MLHwgHeLk/
         MTm72RRFHjxwLwcbrPr+ozNjklBRF18BtUOD4McSE/b5mZz36LPWSqhw7OE2f+bwFuPn
         f0Dg==
X-Forwarded-Encrypted: i=1; AFNElJ9uiorNASmh9ERIMQAZcEVUui/geTZ9695w3otACJ66tWtph6ahqcaldX1E6fAxtJPrfyW9ENhH0+vz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr3Xj7Vwoq5/PTG959GwK5f964kMi+tyblbOE+1qtxTYerUGPJ
	LOMzP0lR8fjC3j8ch6W0JNGZIVK/hNRE/FpLJ4TToliTC1N8xd30Nid87z0ItkFxQOR9aYNneOR
	arNBa0kkULtKPVc03XvqWmTQWYqoTXMiPvAaQw8dP
X-Gm-Gg: Acq92OEittJKPQxNS9VYJAYLvMZ2UsS5ax2RWu4miW3HerrDD4CCZ+43NEtu6T+9kvS
	F5U+9xIsqrOnblTg/SPdcbXZ1HvsvamnK5uCtt3wyREtRYITeQyCeuXOLWYed7umZmRZyrK4u8v
	dnj2TnV+041JQ9aJPRXv0Q+vK8XXDHQ5HueNUVkT+XqtaXGLDT3RMiRlybN7sz6Leq7+Jz9EKd/
	rWm5kYvZaDImsXtg1rDcoE5kg6ivHy+gJOTu4eDoTFm8gHkZS54ouDJxaRdUO7IyfTlkgo37Dox
	tZmcT/I0gTZRODXQAxbAYhdA7vfg7itew4Nq9964yplXlHFNZrFh
X-Received: by 2002:a05:622a:130d:b0:516:3def:1cf4 with SMTP id
 d75a77b69052e-516c52f91damr11257861cf.1.1779383184387; Thu, 21 May 2026
 10:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512090408.794195-1-aneesh.kumar@kernel.org> <20260512090408.794195-5-aneesh.kumar@kernel.org>
In-Reply-To: <20260512090408.794195-5-aneesh.kumar@kernel.org>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 21 May 2026 18:06:09 +0100
X-Gm-Features: AVHnY4ISudxxSxVvcLPDn4R1NI9d_Ojyz-0XSa_zA0I3j6uTkfH8ncuvoLHXOtc
Message-ID: <CAFgf54o4ZnvnJ3369bHb10tvJJVP+5YWq=ec4Jh5K6S6U9uNEA@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>, Petr Tesarik <ptesarik@suse.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:05=E2=80=AFAM Aneesh Kumar K.V (Arm)
<aneesh.kumar@kernel.org> wrote:
> @@ -1411,6 +1436,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
dev, phys_addr_t orig_addr,
>         if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>                 pr_warn_once("Memory encryption is active and system is u=
sing DMA bounce buffers\n");
>
> +       /*
> +        * if we are trying to swiotlb map a decrypted paddr or the paddr=
 is encrypted
> +        * but the device is forcing decryption, use decrypted io_tlb_mem
> +        */
> +       if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))

I don't think swiotlb needs to know about force_dma_unencrypted(), the
dma/direct caller should have all the information to pass the
appropriate flags.

Thanks.
Mostafa

> +               require_decrypted =3D true;
> +
> +       if (require_decrypted !=3D mem->unencrypted)
> +               return (phys_addr_t)DMA_MAPPING_ERROR;
> +
