Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3489541CB5A
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791856259; cv=pass; b=KAexmdb6oifyX2p5vKFkUPYdbLf54Mg0DX6omTLEg2Fp2brThxb3lzlBFL9zzBHn5LSf+8j6qv4/1M/7/QebfxD/EN7wB25NrnjlI/wjc9DgOuY7nQoWn0Sn22BJNjNJeYeV8QGkvBY8z1wmseMZUcg1ALPvnIG7au/w81Bfbkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791856259; c=relaxed/simple;
	bh=/vRL43RBoaTQZUND/DANud2hJVE55ck4bN3ZdQ87weI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+z/+z9bPTnSCor+LkCO6nYy2oWxAM314laEpIcKJM3AY59Nvq7gEvpmup1TjGQ4V45Kfr/tgmCwQhqGzpwHAHsaM1xc4IxVobKAil5xg/S1QcIO/hHRBIeErNDBkyabTQA63D2mWzpM3Wu9dbPWyrUkfXg+o1P6Oc7V+CJ/tkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXCqxtC/; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXCqxtC/"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ab38a051aaso18083667b3.3
        for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 18:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791856257; cv=none;
        d=google.com; s=arc-20260327;
        b=QRraKncQ/ihOyo2Oph0vYe6VYBxNZJnPBcM/C0bfURZjFW3SDsMp+SioO5Jy0TIqLi
         n7vO5G8/ptfDYDojUbfikzG176yO1nhhWnHSk2d3xT/Xwamn48YkMU3oVzFKuUXGcllG
         +7eB93E+cH3nukhnDl13pIOzxpF17JF3tvlD8PhZrydvt7GRXQMjMpbdkygzPheEdw2Z
         q3AFGoWP1h/m1aff+5ib/At4Gq7dhc++QozmA3HLdRDLjvHQtuYm74n8hO8oz2gXQH3l
         ydNHZGn+qRZPr7Ie2XIneiRQ8wE28X2oM4bkNjDXvQxsnukRfFMJgZMqD2RNMSa1xgy+
         5dSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kb6BG6bD9irmubZfXVt/LqCaf/y3R6iRRzcq1a8dN8w=;
        fh=/ghgulHz1a2LmxvwL2zjQYRkoIbGCoJLvXagtHOMV3I=;
        b=sVZ0fwGjwkMM6camdJBN37W3tDcA1dTtYlgTy+HmxLX5MTdxOlj2rs1hHTWZEjsExn
         i+KHNEYdZScA/GMxF6Y6vmnQPiOxKNRAq/6pq80MBm+uwBBOfwHu7ZD95altVvxVAQA2
         EZKfZvUEcLEL6iQDTE9/A1Czi0DLoR84amErQevjubjFwsarzybGeA1HNxOMGjc9baK/
         iisvpmEQlyvDi3Kvirhu10qEzzpAfQtp6z/ynkNMMHPHi0qMfYbjP81M8ZvOmeUE2M0d
         1UwF4YjMvJh0y++8vqkPvuLRDAUTGR73clNg3Eh2FAl3Yq6vTLBfKZve6exnWzrDKdOy
         Nm9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791856257; x=1792461057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kb6BG6bD9irmubZfXVt/LqCaf/y3R6iRRzcq1a8dN8w=;
        b=bXCqxtC/2/5AXMxTAsopchZrJtNWxMpa3yu5b6S4o5PmIwniGe2/eXh7rHrUspV59W
         Eox6Jofxg1dciCIgj4kQbGCw2Bhn6rpZN3yJ4oQI033Xho32f4pouaqfo6oUT12pTEHH
         cZO1lSr4jxGt2KjVMdjbURAz5W6mkcEHDUf5TeeoEVJMEFe2FqoTC2r8P8GQd7oW3YYr
         t6aCQIL8zwC0yBXdlaAzcZyD7qVb6E0iHeHQupPqgwTIMHKH1WIKPsIEDATvpoymRaV/
         UrqwlCJWJkF8n4LD226aVvbR4E8++blc9sqG1yuCbPbYDc+ejLLu/VNrlOGvSI7T71Jm
         UzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791856257; x=1792461057;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kb6BG6bD9irmubZfXVt/LqCaf/y3R6iRRzcq1a8dN8w=;
        b=ql6WgtaJJoUD2c0C+6Q5eCZ+aM/g1i3FUmJK9C7VyjAKfU64nFSBTkNcwRAWCcMEsB
         2TSmCrhT87f8kIeTFw2S/zTSGCoTCdhCjWi7kRXrYmbIZKFqhiy8xEIL0oRsF81h2yqh
         B90z2Rn3d3qvFJXmMj2RA3lBn6KeT43kHwg5LgUl1wt5fE6HYHxEbztObHfjtluYLPav
         dZPt2ZbC/I33K7m8QQaI+J5JIni/do8OlHz0fqjmXXWJB7y+wx38DrCRsk+yAQ17utxQ
         gelrUr3SxBsnBONQiAnbm5lvIM+Ex4yohnT/IGOQa02OQBtjg8ky6ZV2o3vPHFyiXsGt
         zoHA==
X-Forwarded-Encrypted: i=1; AKwUvBwxQpF79G/D1uU3fMy5n8Pr6u63Jsn3VXicLjMs2emDHxG0XjbD1H23xmZHOIRsGzKy+f6FSoouKCbX@vger.kernel.org
X-Gm-Message-State: AFq9FYKLgone/l0XmJ8oTF3YbtW4kzq/5T8aN8OBSTjkCDntL1DUKWjy
	riDfa1MeujP4OvynwQgez1F+ul/4b5LBJR7/qhD3MthrawfOx1kMH9937twvg3KcJo26GQL9X0v
	zK+dm0R1GOQYPaYB2dQ8pzQuPebj5WL0=
X-Gm-Gg: AYBFou2ibIaZEEMU5CbhwdXsxhL9PFuAJgzGBUUVKaeNc49rGVtmDLBMhQSHZwNjbgi
	RLM1gg2un993g8/VTfIOfPuhVJY9P47Yc4KlfpBKb3I4L1qkOKbf0xqjt5G1IX2VXmxDMaEObFv
	PaSkPPGZAwCPC7bTToOuQ2vsuQ2IKmgRfIeSikS3iIu9KouatTBjGYFUZpyerKOZll9RCHAGjmr
	HpjUCFU8Z7UjpEHdlf+ZRFYnQHAo1x4W4LgonuqN1dUelfsvAmjmVAe7oYFyKUSXPtdHeP7KX+6
	ih/IT+1cKZ7LGfYJgEZvYHoN8AnhjketHQpclTS1CfORJabUuedQV408jSiiPISQY5KyeS9AadS
	NPLO4UrLZBVnZ25wxBrA=
X-Received: by 2002:a05:690e:d0e:b0:677:a918:f8e3 with SMTP id
 956f58d0204a3-679362620c9mr3644793d50.71.1791856256842; Mon, 12 Oct 2026
 18:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012150404.555918-1-ekffu200098@gmail.com> <08f3f635-92af-41fc-a113-4bfb31b76022-agordeev@linux.ibm.com>
In-Reply-To: <08f3f635-92af-41fc-a113-4bfb31b76022-agordeev@linux.ibm.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 13 Oct 2026 10:50:44 +0900
X-Gm-Features: AclHuK9yIO8f5xT_v9h5oz_L5LRXwwe8pLep0FsXwb4WsFsaASzvMpTltpDI36M
Message-ID: <CABFDxMFEsNO94Q_73WtNiWSN33hya1Y6GVDhH=7q-dkwCDnocQ@mail.gmail.com>
Subject: Re: [PATCH] s390/sclp: Remove redundant memset after memblock_alloc_low
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 10=EC=9B=94 13=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:18,=
 Alexander Gordeev <agordeev@linux.ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> On Tue, Oct 13, 2026 at 12:04:02AM +0900, Sang-Heon Jeon wrote:
> > memblock_alloc_low() returns zeroed memory, so the memset after the
> > allocation in sclp_early_get_core_info() is redundant.
> >
> > So remove the memset.
> >
> > No functional change.
>
> Well, actually there is :)

Yeah, really haha :)

> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  drivers/s390/char/sclp_early.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_ea=
rly.c
> > index 22dd797e6229..821b61727d1f 100644
> > --- a/drivers/s390/char/sclp_early.c
> > +++ b/drivers/s390/char/sclp_early.c
> > @@ -138,7 +138,6 @@ int __init sclp_early_get_core_info(struct sclp_cor=
e_info *info)
> >       if (!sccb)
> >               return -ENOMEM;
> >
> > -     memset(sccb, 0, length);
> >       sccb->header.length =3D length;
> >       sccb->header.control_mask[2] =3D 0x80;
> >       if (sclp_early_cmd(SCLP_CMDW_READ_CPU_INFO, sccb)) {
>
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks for reviewing!

Best regards,
Sang-Heon Jeon
