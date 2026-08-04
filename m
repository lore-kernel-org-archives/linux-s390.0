Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330942047F
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831892; cv=pass; b=t3fwccALJFbEeYwBKtX5LfJQACYstX05sGpP2a1vgXEiWSRDakBg2erKHQ+llDXJEzBr0wK5mZUKHgHQCSWGqBga6OttIJQB6emitq0SRNqYf44zj74sdjuDAvUd2Z8/9RI65LGGsWqE0i290ZaxL8py1HxTprFFxStYcde8QzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831892; c=relaxed/simple;
	bh=E7A62dEXRMnTvouK15ML4xNn9IbWSm4bfkJkGy+Osog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UezNtjgCCfMnC5JbY/Mh2xL/fj77rE/TUx/flz/1QKqmDoZUF2HA/R03Oa9pf2eEmxN4NrQtagewaaivp3aau8QniWaL/CKikQ7pWjjO6pGux9o3+8QT0qVHBH4gG5hwlhjF99V1rBZwGwBipMh42zPgU/JACys/P0+opFv6KeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g27dOffX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXm5s2IQ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g27dOffX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXm5s2IQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785831890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm8UobsJTlbPE9vGUwkb/Bbwe8GB4ZtONSzPRFILqXM=;
	b=g27dOffXQ3uO6eJbldztQdmZ9KqNgd1t676DBV4/sLeaybCftuCjApDeglxA0UjPmREJ8n
	qqM6hWuTbU1uO1mnrvRaHQq5NNPe5DGhpniEYnq2t2QSRSYm5GWvqox2q/hB2wJikksbiv
	HhdVAegGO339xvCptrGN0rGqERwnTcI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-MV1sLo61N7CSW3lpOpcQgg-1; Tue, 04 Aug 2026 04:24:48 -0400
X-MC-Unique: MV1sLo61N7CSW3lpOpcQgg-1
X-Mimecast-MFC-AGG-ID: MV1sLo61N7CSW3lpOpcQgg_1785831887
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f810c8aebso2602624f8f.2
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 01:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785831887; cv=none;
        d=google.com; s=arc-20260327;
        b=mWW/5VUfsXjtgINGnSthDP7SdJa771Q2PdVJA4Y1ij5HZNMbKivScwZVIPXEWIDhCX
         VH983fLV5OnsjgIA0KRNj1TkGbgSc70N89X2mRqqd7kJEcUHkuoNnOzGAv4nDp8nnEdN
         UHEAc7bKrhNHVQyK2KqKvR2xgQPrqixcu6esGZL8eDB7Uih1MJLrAsNNf3gCBBv9YdBU
         11UW6dchuCmPghm7cKxlcox+UTqZgOSerTfSWnTPYuQPVMvTSFEw4pWFrPvnN2NLXkjm
         DqOdaO/lCXTkEvp6Ude+9A8cZ8p9Yw3fidTLwKDUEuL7SestQ1SN2gyxnOzCVmh4XPBG
         GxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tm8UobsJTlbPE9vGUwkb/Bbwe8GB4ZtONSzPRFILqXM=;
        fh=C8dAk7N88NZ1Yk4xXw7mDrvRjZ62l91PGtbNhygXs1o=;
        b=fZtD3c1GKF2xU2gYLBXQoyHZx5ukQai8ckTtghqjY/iqRRkC1vkJbXYacnJXrV2jMn
         cvn2IV+BDOQ178HjjJ4J5uXHe26YBVOM/Bl8elqAvgFMzLxgAzydR6OufwoW1g+5SNOa
         4MwNQYlU3sJXrICxrstzilKe4yFOPqwTTNpclmsimTdrPMA+f4gtw+dW9/lrITzoTP8+
         rDvPNgQWnsHaKBN3QS0uw6TfHgak6zdmKBF2vvIpcAEU9yX+WW2ue+2BO/POA+gP/TEw
         VSNliijJyF+WTS7ylH4oNcL9AuchPlmke6wh6Vh9MrnfBi2z7+MeIaaRLB/rLHYh5C+y
         S4JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785831887; x=1786436687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tm8UobsJTlbPE9vGUwkb/Bbwe8GB4ZtONSzPRFILqXM=;
        b=XXm5s2IQ9WnnfT9uUNYHfa2DAMbZAQWWXQ2jLfmcMtnWcqnGt4jYt72e77JtSHUKEy
         CT4sjQo37m/0YYMYMuj4LjVt0ThUENI4tl8VEtpY18gjbm7pKypW8RiOLr80Lj4DiEg0
         4bbKsFmDCuBzOib8WyyVT0GrocCjUPSKrw5t9Ux/Fl4FUk1mx40itfq+9noV2glHtwdT
         clR/eTXwTJydojPTHtDz4AQt5mJ5Blas6JeL6bGwhjZmw6JJd9v/qibBpo8OymtttJ9x
         aq3jx+PjzywMl3IWCKSHn8JBtokPdAEI1U0eHoRvZoo83yk2Ed6uEptnnp2TyIYL4yCK
         XbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785831887; x=1786436687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tm8UobsJTlbPE9vGUwkb/Bbwe8GB4ZtONSzPRFILqXM=;
        b=GwXNMdgVJcjUE3x2IRTXz0xAn3DAr6hDtEnG3uD8yvUP2I8jdwhRjwEswH8B1lrpli
         xD1YmIjDmoRpdwuUXLYittfHfdWIBb31KzFfYXrXqJ7YUpiZkhSAlDBMbtTe0pyVVTXp
         0vE+ZF/XAo2GK0x8ckFRksCeU90A7PcW2cR4MmwHYY6evHBeURaDIHg5XGu+wrKJQ6FH
         NrT7QTgUpzjC8/MwWxbBiCN1HQg0qkFLFIg4nIFW3W7AA9T0yNx569LW/8pyZCHqCi4W
         RaexDgCsbdb8VcxGOSwQKyCTc/4AD/gwpPsMXoBhrrpLNQgtx6cSGiQQCej1dDY+acw0
         XFdw==
X-Forwarded-Encrypted: i=1; AHgh+RoRkf7eBi8wnEsFZgWQf+6ebhTci4hYIeskyGu0Adc65JG36wWmrNb5EKd9orFfqWIhN8Hhjaux7qTo@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlV/mKsETrUROdG0Ak4b8vRgXUOJCsAgL8ZSL8XbqIe+ORuXB
	4SDFhoi6F3og3x9PYOcBKSVZaIjD9pCdKDM3DsmCwjORsynhcVNaEhKVgm2D2o8VoM3UFxm6BWI
	BS/xs72k2wEZA5jrcmmIRXl558eD4GK1cGyYSWit9gz34JPJt1/A3ROgvUxzIIMwVljQRHieYMU
	brgfsZsFZpbe+IxYK/lD2CHkbj8Se6UZ1EEMoA3g==
X-Gm-Gg: AR+sD12MmF13JwcNvBUVqnv9qRFEe+3R+hYZnNknaYiUK1OLw6waLXU6nrM+KNcgzb0
	70+6T+loRJVnWIqOjkVGfprHcNEI8UtJgDF882S84JXj51P8xn9xALVwPDUQpZ7eCBo728BEos+
	69xGiueCu4KPybhfu01uRnip+CBrOw0zf2JGpT1MJRGzLQsvl6rV7pan62i7YttVamI535Zr4Cf
	W10EH+zl+u/WIyP7o15UkvN3rOVQiAGk1bHfPu05w59LjKwjnzAnQ9tFEM=
X-Received: by 2002:a05:6000:25e4:b0:47e:aa3e:e75e with SMTP id ffacd0b85a97d-47fd72ba455mr37381043f8f.10.1785831887549;
        Tue, 04 Aug 2026 01:24:47 -0700 (PDT)
X-Received: by 2002:a05:6000:25e4:b0:47e:aa3e:e75e with SMTP id
 ffacd0b85a97d-47fd72ba455mr37380975f8f.10.1785831887214; Tue, 04 Aug 2026
 01:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731160514.1101989-1-pbonzini@redhat.com> <0a9c8cc8-1fa7-4f4c-b7df-e847925c2b24@kernel.org>
In-Reply-To: <0a9c8cc8-1fa7-4f4c-b7df-e847925c2b24@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 10:24:35 +0200
X-Gm-Features: AUfX_mzYzfP1Oin53-9hO_78pedfHqy7zxUVYNXXragKLN1GkC7l6UbBuVt8H4U
Message-ID: <CABgObfb_FN9r+D2F=GNsADP5xt0syFztmy-x==T85ovZKyopRA@mail.gmail.com>
Subject: Re: [PATCH] mm: pull writability check to follow_pfnmap_start()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, Fei Li <fei1.li@intel.com>, Peter Xu <peterx@redhat.com>, 
	linux-s390@vger.kernel.org, linux-mm@kvack.org, Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:55=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
> > index 485df9c2dbdd..34c79b5fcb9b 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3136,9 +3136,12 @@ struct follow_pfnmap_args {
> >        * Inputs:
> >        * @vma: Pointer to @vm_area_struct struct
> >        * @address: the virtual address to walk
> > +      * @write_fault: if true, fail with -EFAULT unless the mapping is
>
> Just wondering whether EPERM would be better.

I considered EACCES, but EFAULT seems more appropriate: it's already
what most callers return, and vm_fault_to_errno() never returns
EACCES.

> > +      * writable
> >        */
> >       struct vm_area_struct *vma;
> >       unsigned long address;
> > +     bool write_fault;
>
> "write_fault" is a rather odd name for this, given that this function wil=
l not
> trigger a write fault.
>
> You want something that matches FOLL_WRITE.
>
> "write_access" / "check_writable" maybe?

Just "write" is what mm/ uses for local variables so I'll use that here too=
.

Paolo

