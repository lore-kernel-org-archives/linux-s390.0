Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59128B7DA
	for <linux-s390@vger.kernel.org>; Sun, 22 Mar 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774165778; cv=pass; b=TQ9Y6KFKP8g/xVqRmE0S+LXG3XHYJ8NPj8rhz4HEYzjwdUQWG4itKCdTjm8DDTfk/eXQDJO2VYP595C6mBS1owdsLIjq2CSkTUhh6F83+OdXAUxHNClfMcHxIPeuWJwQIOVCPSpcpdsE3W5GjFJZKraaCYRh9yFHFBv0EyBIWeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774165778; c=relaxed/simple;
	bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiBlS3WPJjxhYMWhmoJvQAANHR3WWQwkpp4V0AxGuh4M9X5e8hWrIE3rUAShrYbw6JvJTvWvS7UYWq1GoLxIKlrYlJwmOfw6NMHaPdVQFYkijryyl6Upjq43UYKHqE25Hrj8dpootI/TMM1qTA1tPkgz/ONfseQDP66c/d8nAUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+CuJxU+; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+CuJxU+"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd71fb9f06so205823085a.2
        for <linux-s390@vger.kernel.org>; Sun, 22 Mar 2026 00:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774165776; cv=none;
        d=google.com; s=arc-20240605;
        b=D0ItYTrqCYz2bwn7dexo4RV535mwRx4qKJiRJHv5kaQ59Xhxrl2a20rhI5Ki15OMHS
         9fwDaPraQQG72t6BITxydzadYH7Iy4nDSpfRdl/9UaRSNdNeFBggGOW6APQxb5CkMlOu
         MAIZOpyooB/98UYmXrCnGAZROYiW76F2znk2H8u1lHIydWGD8pBcVI1juMjEeF/t2SpI
         zTxsP6M0CCwA73iXO30FWP+NzgC0AQ+PFblfKMAnTzduUxscXUbIM4LzuybcAWIonW+r
         RFyn/9x40mZxM4a7kFtnCX3kvcXuGkVb6Osq4vmBZzNf6aHgBHU7rpJIua1uIXesDktR
         FoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
        fh=lpDUV8W1sD6BBFiUySAv+kx9/TEW/mFqQQFX4MJofo4=;
        b=aJRtrwv2TI2Gpit9BK62rJ2vqE/z/v3P4rzej+XIsOKkSd65KlPafG+PHKmK3q7KNa
         2NGxd1g0YUIxiCm/XnsGgxjf1OLjYk7p6pLvLT9G0tR5s0QjgdF1+LLusBnycXsAAkYy
         fhszTcTFoEsFNHIUKCWCy4lzRumJK2vaccoYiaIQCv8nPrhoSyNFmtb7yjVZF3+yHeiU
         p7km3+Vaq7JXvCf0MCTCcxDmw3MSRHZaUkjX28zD01zfX58IRc1tXSPjfu89yLPmLTcn
         xhizmbVjI8uyGZ3wQ+FYJ1kjDRxEX4ruziMc3Vl29mBMvNwmEyB3B0a7nAW3mvweMnzZ
         H/WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774165776; x=1774770576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
        b=F+CuJxU+Q4DrEWvnxfFZ6jPFM75VPl0dxcjCrPgbCqN0AhmcmkblSYnzZnEsS7vxkP
         vHC8AdYlsqyn6lAhvSMgCDqakyX1MIzoAA339knHj5Kl5q4UiAVlKJtsANx3uJGt109m
         p98dI6ZA66tY0PTsGKOaFaG1q1yxTVNhkEXtqcUqU8k4lWXPva1NNnuRlrlhMGF95Vnb
         daHT0XTCoJ6JUVmWVelfHb4FhbSk31LAeMPARQTidrjhfFLc61cwpqqZSDds3lPRu1uV
         8AIIH+VI5bQO/VS9VHlWfMfncDCVXUsDqoeRjU6+4LeeX2OUjv0/ogiOXHjqtZF+V0Ii
         UBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774165776; x=1774770576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yog4Y4FnY2pw/bISePo6mO0/0jBCwWfyVov9mO2pTgg=;
        b=Sj2Y7E9wiH4WjoLlQv8zwePv6/zjXB/SrvJznFMVaOtxAdbOICjBoOXIkmWMo2pnC2
         gMugf8PAz7tQ0YW8NoIfnJ0zJym1KfjgWul/Zf8Xhb3eRVqkJLCFT9K1axIReNSV/NPl
         SD+e8Kiy6AMuFqJ7d4zf7In4mC1k460Fvf7OSOckZoEuztn50+7LwuaGV74LOCzMwapw
         KlnaEOHZv0L9mRQShvTBWXRC0Is0K/RIq+37Jg2IIzlWZyR8N2F5dMbfCDsKyZHDT1vU
         z1J9vFNVGFw5rrUg0ZRhBz0aQLo3NlhHKVF0lPmfL3WvqH8ehIAL/4EzDFrAVnBwM39O
         ZnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFEodzCc6qiuuQAq2Xi7x3YH2+3v8V3XYBt3p0VcX5N+/nAf7TioZRyOLnHi2fQRazNkGt9if/hN82@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgVlc3s5t8GyciB7ZKQ4uvGcCyt48MYml5RivcI+TzpCALeIN
	JeiG0iNlX3V6WRBAm3YJtOMcKNVQaPRqH5lL2FWFEOXWBiNIm80EuMxjOnpP6Q1H00YPchAN1Pk
	BquK16x9S6GaN+qRLqUoKzeWgwqt6aps=
X-Gm-Gg: ATEYQzysoWlNhyvrPbrcRjytuSwyiNPeQajMWY0c5uLDYrWR32hri26WIgc1aV++7h0
	L2vH6j1NHoaQsYzoyx1jq8jzcDXXrAkvNCqxx6bdlZu3/7WGqrx/5Gx2IyGE1aAXvIYLLd8v8Sd
	nb+j/WHy9PuUcoG6oBKGd6MvGkTxYnwOx5Lhns39mAm8MS7oUts6+8rvoi34gZGZsrQSCNYqspA
	5Lr1/jr3klSV3BIM25ItHRSxz8EeW/bhqIwCL5q5CcKOU0CfWnJUMA2Dnnm4nVfJpUH7l6nAn5n
	JXhTJrLEPw==
X-Received: by 2002:a05:620a:318b:b0:8cf:db7b:6224 with SMTP id
 af79cd13be357-8cfdb7b68e2mr439093885a.59.1774165775634; Sun, 22 Mar 2026
 00:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com> <20260322054309.898214-2-surenb@google.com>
In-Reply-To: <20260322054309.898214-2-surenb@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 22 Mar 2026 15:49:24 +0800
X-Gm-Features: AaiRm53R0BSIBZ-7kcLpHy3OcZIzoW6AMt3M9APBFS4L2dJIHsEh5rSFscqFXrY
Message-ID: <CAGsJ_4yAWxty2PAm0Lp-iDnAm6DpReedRvus7FFQb3A2dKPTYw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm/vma: cleanup error handling path in vma_expand()
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 1:43=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> vma_expand() error handling is a bit confusing with "if (ret) return ret;=
"
> mixed with "if (!ret && ...) ret =3D ...;". Simplify the code to check
> for errors and return immediately after an operation that might fail.
> This also makes later changes to this function more readable.
> Change variable name for storing the error code from "ret" to "err".
>
> No functional change intended.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

LGTM,
Reviewed-by: Barry Song <baohua@kernel.org>
