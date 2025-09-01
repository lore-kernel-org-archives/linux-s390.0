Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837434AB0E
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739856; cv=none; b=W0Cy37ngNcAEd0sjvST9H6NUeVapQ7ehA4dl56kvmYHRcX/e/Xj4FnJ4yC0MZIralLPQwqZKOBjL2w2JW11NxBF+AcpA85cAwvDNvDsXHp4eP6Z6ITsgD+nBssQ+miY7/U6yjDviLOqAdJAzweY70GboIj36GENjxShS2bh0OHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739856; c=relaxed/simple;
	bh=2vLlsr7X2ia5/OeQs8olHZPr7msI9HcqjAeK9e+vndo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6mpC5tV3Uj+/Yx09RK3IiejZC75kG/emGjsIw+rJAXCVUL5R7ayAXB94727nmyXIRc4L3NoOFQ/Xbc7EPTqNE8WyywRsCzcG+3tJldiCyakhvah3evcYmKw9LZjwyYiHy8uAcwsfSsn9CpjXQlEWPmQ1/YCaFZDbupvGHSkh78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=enRVo2Vy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="enRVo2Vy"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b00a9989633so394189866b.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756739853; x=1757344653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVsve/IFMKMWGwAEF879SRkVfMnyldOnTnxfs/L/xuQ=;
        b=enRVo2VyAL6uLEEHKwECASXnBq5VWF/piuntTrY1HwPtweYtQekMdHHjhRpXAe+6xW
         mXRBHyZUk9MoUnr3KHo6yEBcw8ac9T2tTBmOv8xlbCeW0pHi0PGXNnDzBGy3KhtqrT1U
         M2KgVQYKaEQh5UrqQbuyOsqBYHazkw1ABw9FY+3Ub61C0d5ylKmB84cI1QSHmtMgYHah
         fCovDPYjtjh86yGV+9lFYsK0BSU2Jv5GeFK8a6gBRmEXqAEH5tgVaJM/vFqqeFAGFGAz
         Nxu8MCLHfwzCAenJGFfgRd5w+cVBaFOmXdIIV4O+PewONuWycqetniZVpZ7u9k/0rMMv
         Q+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739853; x=1757344653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVsve/IFMKMWGwAEF879SRkVfMnyldOnTnxfs/L/xuQ=;
        b=qzWqLNPyufWeunBcywJiXyN5B3YKsqw1cbBTf/wepYdaIADG27agIvGwMwleD4wEn9
         xNqpDtqwApE63lFnrynYQRlHgeKRk9a76BQItABf1wLyZVy2G+eolk6JChC1aE4PSjaN
         KTLXeDiiWZ64PhtAvvM8SxSfqUJcVcJ9oSD3Ht4XHX7VJ3RmwOQD1b9FFEinnD6GvXVL
         kH9iJrTeXZ0G6gqEuijNHM0sFr4T8lpOuMor7BfC8UMUCWgV46UrB8msqWgGKRsy7vgo
         PFrywiie6PSplM4OADKeig2zHCfdOd/Ry6P2fqKMErD+4wbcWCG50V3oq6txvxb3VVuO
         7QGw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ss3oHEQ5GHLKdW3G16/Y3XA+WTp0qc2oguNbAKgAOCKeeDmnLnZINDzqgivihVD+6V2ZVv6NrAzp@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAUH9Doo1kgfX1CgB16lweMNWClCBPNvzbheyWBCbx/VrbB6G
	wBVZDm/Wqu4H4UTeIPNe0bH76eEr/m+m07Vgzo24JkXyzw9DGRkMuNLNRsB3sqkp6WjClH2oQ96
	HYKOpkOKWZCqGDDJ9KyD+SNfztN4gpZXAoydX2qTIcA==
X-Gm-Gg: ASbGncuTxsJrsV2cemTMUXcxm+3lPvDJCUiGeCswo3BZr+YTN5MeOTTVCH/eXyVgUnH
	D2Nqo+gdC6E0PMptDXWyxFALYmFJ98w43d+970+Y20rWNUUmEvglp5GOBPtpcNJ0gA9aW7Vmdnq
	a78G1GW93CuexrZ3ZIN2E1sPpygg2Iql2mhAqIRqhvWnK5RRWqPbIixBcMcuNbzYIeWUlOVKCCl
	F0DeDMSnJAsUdNB92W268hNQ1CJX8C6iHM=
X-Google-Smtp-Source: AGHT+IG/xTCJ9bj+alHxnm8uZcbqfurR+IyDtwLk2ZtZW9b4+JSGWCUUEu7vdYbFqHJ+Zaxrj6LPdykdWiyzaO+0sH8=
X-Received: by 2002:a17:907:d8d:b0:afe:5c9d:c7f1 with SMTP id
 a640c23a62f3a-b01d8a8b328mr935024266b.10.1756739851758; Mon, 01 Sep 2025
 08:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-12-max.kellermann@ionos.com> <081a7335-ec84-4e26-9ea2-251e3fc42277@redhat.com>
In-Reply-To: <081a7335-ec84-4e26-9ea2-251e3fc42277@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:17:20 +0200
X-Gm-Features: Ac12FXzbdsR-8kES_4on1Dew__ksXVksfxEkYJjm0-lwqH8RlE2IsInEJr70z8I
Message-ID: <CAKPOu+8xJJ91pOymWxJ0W3wum_mHPkn_nR7BegzmrjFwEMLrGg@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] mm: constify assert/test functions in mm.h
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:07=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> > -static inline void assert_fault_locked(struct vm_fault *vmf)
> > +static inline void assert_fault_locked(const struct vm_fault *vmf)
> >   {
>
> This confused me a bit: in the upper variant it's "*const" and here it's
> "const *".

That was indeed a mistake. Both should be "const*const".

> There are multiple such cases here, which might imply that it is not
> "relatively trivial to const-ify them". :)

I double-checked this patch and couldn't find any other such mistake.
Or do you mean the function vs prototype thing on parameter values?
