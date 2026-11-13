Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573510;
	b=n7fps6pkd1r6jtc5zqH+qMqYWr85Ral5oN40hj/JQXJPWFx/XdYNO4IaAw2cjdNyc3PF
	 8kg+eSA2+5BMnG0tp5JHDQmEVzyimznCgsDIvg3Czzrfkc2JXcQaGTsQmzN5/d+1VThEZ
	 +gI2Y3gjL/WsNVGyniKDDJQyu9aj1xWgiDWLVOBRzl32gSmnZaC0HrRzERaBnEuGfOQy7
	 BaqsM5SqXU8ijVsgWGKsayiwNTJ96QIiM96hlrnYlSOQMUZ7KPr93Wp/IdBbIjZL0S5vT
	 7czfFkkKcPcjSVXyWR0TEO9+9yP9oIpWwiIs4cXVnA56YoizbiZkJHHz0TC/GxofykQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
	b=D4p4S6btPJwlvtnxA0y01vWzgEKUanR+ahZlpqApZ9pIwSCSX14ehF16DuedtyNFQcE/
	 e9q4amP+tUTk0aFUJdgFZrARioKWRpH5qPBMlam9CVSBGQUwpIaQOdQjumBPgD8NQru2F
	 P6xTs6672bsRqudM04D8VG1eBAiKBQG6ViXxbSv8Vg1vA6EVY7yLzoVp5QZByQVhSbUJg
	 +eQoJ6eaYmKdTzk9ymcbtWGt0zduzlisIgxCd0+AfxPonrrTIfupkBYzkYQFSjnZQ/XCf
	 HRl8hH3B27jN40c0zRlxvkW6lBOoO/6DtpMHhZsC/Aq+40P9HShK/BTYNUZf94FzErw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D6606A333
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 12:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D58D6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so9108325e9.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573508; x=1795178308; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=Bz2+TnPIApHKvsf08kyiSuJZ5AWViHONwTwuNXVAuo2u8JGXjKnEoxSd3hG/r/h3b1
         tdsUEBtaZSOWfU3+mD3LjyqvBKt9Vc6RBsvkZZTD05u5eCDGhnWto1Wbu/C0r64DVVdd
         h2TGnt6meedDH7Iwjf2Hw2JxWOY8jwAvEAcAC10FURsf5jjp4p/KJzFYjzuPwuYFNKea
         Iij0h8HoPs5opXKf2XwMBJpd5hsYSV0+BHP/DvKdCCgwNFtbeIFAwqDf2ag0NBOCbqs2
         OXWiZmXbdGCixyOlqQBMgrkFkrhg1VmbSdmvvBdeQ4Vz+QMvhYl+k9AO6FJ5UW1pg6b2
         DVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573508; x=1795178308;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=v3FIEHXvGU18gZSCDpFzn39N3WJrEXB+spnF0i6WVHRXcntRdedMaIocZ8NAa4QMlz
         U+GjY/ENm1See7WOavwJ1fQA1o1MVrlSWTECLEdsnyUtxqBpn2a6TBuMa43dPaZLX0lx
         wKr9NycmT90W8UvyHyrg86wL9jxRRPI7SHhs5LGqjc1ax3ixTChqLtD24GF7U9lOZAMn
         FLDrVxU/Ky7RA9j/Mgv3dx4OHJAznj1thC54GkD2eFznYTh4xG3raX1u+RY97sVfylDI
         B4190hAzUs6snYFLyrrVWtKESOHW0GDLoTK02dqqD0681156ZypAuMbpIvU3qjFqjBz2
         OMqA==
X-Forwarded-Encrypted: i=1; AL+hErFM/wGhqZ2tZfkFNV9/Nvezeo1IXMP1Nk/qx+uoz2dyqvYLTBeJmDh8XA8lfjvhMYvVITm5l4+8j7JD@vger.kernel.org
X-Gm-Message-State: APuU4Z8IrjP5PawCZiEUTmHgi65UZ9mrrfsyYmZHg3YxHm+0YKQdOtWU
	tmKsnTfEX8qxfjGDE9xaH1FWnNUwxrHyKy0Rp7GRvba8lMBEi3hRrNGLQJU4a/i9PtI4
X-Gm-Gg: AYBFou0PYP3ujff+Kmvpxhza1sqzwtcvQ2hEyHNfPXEq5lmwm2+I624Rn52gnOBS6va
	vXkdnHzTYQ1vk6QxUSyblFYnSEsrL+mZmqSlcGIDdkOW2PYtjSdNjAQEc9Lt9igWkLiUulr5Swf
	im0lU88AU0O2zPnt+HnNZDG0E3T/5anuoQ7LKAXP5mzFzrToeBvrF++O6ZWGtDol+2hdelJfItd
	Wo5YugrgQxNozX3hiUmP63dy9SrEJFzLOvsuVYEQNOstTtjW8EETXCb6rGEdjTjTf1cUzIYHFe5
	3rqrr4I9RxeCpAbvBSAgAKm/KPcOSRsWz23zphFazFXToOGeGtbZ8b6gFhG/lXc1w2w3HsflKuE
	jd4hYQbtMRXe7KCSb2FeStJprtl9FjHvIqhI61us/bBf2tKNzumTXPr0kr7IarLBUVLfrQdgUeZ
	hsV40zPpqmsxyMTQbwrJaXdBYP4GHOnkcufrxSpo7eYQUs+fpeZ2mOq5xmlNEoyAEtHnq3RFirV
	IK8XMUBsg2IMg3dBjRBJBUcG2+mQTxSPYa3A5DIrzT8HPb5duplCG0Z3q8l8Tupu+usQsRc/ACh
	rjIJg8UgHRVMitU8BnvMRfiNvi5ylJ0UHkcVF9wPJg6wpCSEhw5C4xdaYgKBZJs=
X-Received: by 2002:a05:600c:a596:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4bb55a86fb2mr24790785e9.11.1794573508217;
        Fri, 13 Nov 2026 04:38:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm48348475e9.2.2026.11.13.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:38:27 -0800 (PST)
Message-ID: <28a33fa649dcaae2eadcc934ec49fa591ec1c283.camel@amutable.com>
Subject: Re: [PATCH RFC 20/41] apparmor: use fc_init_pseudo() for apparmorfs
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 13:38:25 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/apparmor/apparmorfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/apparmor/apparmorfs.c
> b/security/apparmor/apparmorfs.c
> index a99366467217..351ea3a7120e 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/rcupdate.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/zstd.h>
> =C2=A0#include <linux/string.h>
> @@ -263,6 +264,7 @@ static const struct fs_context_operations
> apparmorfs_context_ops =3D {
> =C2=A0
> =C2=A0static int apparmorfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &apparmorfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
