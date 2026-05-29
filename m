Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF040371076
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073819; cv=pass; b=SBo1s8qbLGs4VBRKwxdqYohhALNVadFOJ+PJtkuuxsHXHbH7vce3IXdrBdZwTbpWgkcNsjjThEnyTYdRzunSymKzQdusuzmnShIorF/JaF9wNY+4lqlh7ak0xQtfKtJV8ZDyvXgo8tV0jzn1sy3CwkbkU2ftD7nf+WlRo5IY6/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073819; c=relaxed/simple;
	bh=Cqj46itu7YvhryEp4XiC09o/JiR3dUKvq7oz0vPTGGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrNsnRrynwkHb+d1uVssMO6/nboiGj/KgwM20Sue0sUPA8sI2R8rmDNytLcYBAPhepcHAXsw9acat2l+Xtv6/3Bu1O9A3466i6RFWYbQ2Qr+fi8ImXkCcqm1ZjkF/jhBQEpNPOO/nUijC4r7VM1RSVcevipFE4PnitbVNN04KgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2Og7CjR; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2Og7CjR"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304da3b4508so188142eec.2
        for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 09:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780073818; cv=none;
        d=google.com; s=arc-20240605;
        b=jjTTPL5W6C28KulD0MBTjOOVsxxQ0v7tHSi4ONmkf7IWbYSB2mcIbIHmTXDJdw0PEp
         GjFbpB9MgaHk9qkdFOzFZueRgyrNlD2/JfmV1JbtwA5PELOSG3L5+8wA4v0Jb4FTFvYD
         UvKa5GEmEY1yT3ssQocxPw/DMfMdh0qJubiHl6txNsGZhgIJlZezr2ct5P54xRvxI4Ha
         I6n3HLgbfGjZOc5lW1stUj6bqAp0klz2RwI4Y+bWUivyK8MRRxAFkanc2RSyaqIaFWlu
         zUWLDQtj96GZ8KpL2uLRDJwuPE47f2lebJG0c2oMTXIWMWC5LM2kTI0MVu1qrKJk5J9D
         64ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cqj46itu7YvhryEp4XiC09o/JiR3dUKvq7oz0vPTGGw=;
        fh=o/o4dv+n692Dt+jNa5wfMCrj0qgJOiAAhsPTrQKAxLg=;
        b=cVLxCuG9/oM7yNf/+19s31GVj3+bBJA/I+DeyDWQdsethuJ2G8ngSqhovjO5xIhXDn
         zn7s3hbHAWBTprJ8ZNOqIOdvHsKkvku1DfzuThkymcJ6M5WwI02czxac4MdP9BLu6MQ7
         /Ky8RrEHjTh3cNHpZadyH4sP0y4RIJ2RH0eGOEEWNmDZsYP/tXmyp8KaPqhzi8OteJcb
         C4fUZWH7ocVlAso7gBPmD2LrFe31RhtR6q/sBaIRJ4OjrUTNhbULwFqTcYz7bnuEbf/Y
         NcIQ1t11qoF0Nsj2UG5O5j2ghauUUyWy7bGrnFCt4q8NzG+FG1DcfaQ/Ve/Yz4dEuSHW
         apgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073818; x=1780678618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cqj46itu7YvhryEp4XiC09o/JiR3dUKvq7oz0vPTGGw=;
        b=L2Og7CjRQ+YHM9GnQoDJIEHXqMuBE3Z3phgKUKC5lE4mBLYwXhTsAbxssuu+oCRnlX
         /j33KogqWFk1HRiB7uFNEbZYsDseR5L+nWOQTB6hUtdAr5+C+/mYHBextJZ258PJFALh
         dNEQCIYcKMsxTdmzCE3XR46RzeX2ClaAbgYmyzZ+XhiiLb9FOQWalcTbeUgmK36xvKnf
         O+/uvAyb6QH/uKMgrgXjkgva6dsZvp3VoQjYbT0lhhBmlivD80kj9IlXnqRoreuTypdu
         z+2kcgNojBMhth0vU+PMql7O/OvtH16qrtcP9R71i/pueWaf1fybuJL145WFVploc+aj
         bzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073818; x=1780678618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cqj46itu7YvhryEp4XiC09o/JiR3dUKvq7oz0vPTGGw=;
        b=S3u9/aJFQL0XHRdtoBJ38O4ViE4/3sc9ITtb5OoWGBtHz5uFVeiJBWBAZy8uJb6yA/
         puONicK//MLY56ZuLgT1mO9M8MDYCOzLJNueHCt3a1dJoNidfjDAUkU7uh1HcHbD+jFs
         1W0OQvABGHzNid834Vb9OHByvClLStpBBLYxg4zIL98V4IA4aWjZnXdDjVwDyR5RoIxh
         AW3qSBIGXe9/NmawgTOkPTGS1t97uYAgsZUKt6oJHlKa8cJOWVrTFCOFMDqg7z4i75kx
         /Z7Ror4KPJ8+3xxU6W2YQD6cJA1KFdAD6RSYdnaVb8xDyuP3L5zdHPqANq4fdXeHdZhE
         FEOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZDUdRqP8pHvPdUshPG/RotK9cg4mA2qt2PiMr8QgOlIlriMFvPMzFR7CEK2sUfmsdFiGNsNVB57hy@vger.kernel.org
X-Gm-Message-State: AOJu0YyXeDt0nlgRn6XzFLGr5vlyvRGC7spypa19xeFx5xSwajqEwDYU
	U6SzaMSJpWNVbViSWuVZFIVij63KvepY2712DVvYO6cPtATpYy4y8V4snkj8dzBUlO1yOm01Q6N
	VmhX6VqIhBzZC/B6kPcN/v14bVwYmZVI=
X-Gm-Gg: Acq92OEYt7nBMb3mRuj8fX/Xq229ZJ6WXIvF0nnC7Fwhu1UfrHWV38m12L2BLCcftn7
	iWubx/OoBI7oBE0Y/38QoFygnZ70we6fxt6Leu4WiogOW+MP2eo4YxhYMvQwSSn8JBvW8Db1EiC
	zkcWaeCL0niPwMnmSsBqf/zLeqlCbNdRMU2HYKW+OmEb681iX7kkIJsbR4ij2QIN0orm/bKStnX
	SW1JlVN0dog+L3DB/i5RJzOBtPv0M3NZhnr5AgnG1alzTW509s/mir0EtdlghOVFL9ds9hyYsT2
	clrWT3nSz1R4AF1nLrEu1PDqbqlw+OtKxb3UP/8S9fCRQlYwAHFTCvFKDLT+fWmiW2IrIJ7KMCa
	KFsUaFGqIPZMVdhxK03/OpQKtUSTOEOXIVw==
X-Received: by 2002:a05:7300:ef83:b0:2ce:db5e:354b with SMTP id
 5a478bee46e88-304fa68ddbamr139320eec.6.1780073817734; Fri, 29 May 2026
 09:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529145752.1209016-1-japo@linux.ibm.com>
In-Reply-To: <20260529145752.1209016-1-japo@linux.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 May 2026 18:56:45 +0200
X-Gm-Features: AVHnY4JYjhkvJGsVVBxQ4qyfPzykgr6M7vdApOZCndTkgwrTNRpPxuKfHWpObS0
Message-ID: <CANiq72m7D7P=dV69FMZMOwUVy_Yr464F_4s=194-iUX4pdt-SQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] s390: Enable Rust support and add required arch glue
To: Jan Polensky <japo@linux.ibm.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 4:58=E2=80=AFPM Jan Polensky <japo@linux.ibm.com> w=
rote:
>
> Tested against: rustc 1.96.0-beta.7 (6be5f81e1 2026-05-17)

Rust 1.96.0 is released! :)

Cheers,
Miguel
