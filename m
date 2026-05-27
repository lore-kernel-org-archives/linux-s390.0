Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963BB3D0916
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883839; cv=pass; b=cHTXtxuJVIc3HkCqYgrASfjTJsK+LvG/MP3sS+OYI+lec/EqDc1h0tTxXcPE29eas8d0arqvbEePy9mkfjPiHBcGtRTRtJqPdVaERpzMRmwUlAtbTtLyuUyEvoDAjjgnWJ2HmO1PvLSA93rVcYn9s45bIAZXlQBxQqkEXg7o6sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883839; c=relaxed/simple;
	bh=9SMvJts0+Ko8/KsbmBYJVEEWqO8MvsW6A3genso8CbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkhMFZ4EF8dAAuQiopXSLALSFk1Y3fW22ja9T+WQvhLlveJ700vrGoGLDNQX38RXw2zcb/9LAgZ6vf46e+jR8yS7Fuc1usaLKnxDs38HyhQuSJtfqChqxR2RFw1/JtrCKf6VVpemFx8fuXsHIUu+lDsHaT9a/RDorke1iAdv+zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjSt9NWc; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjSt9NWc"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304559733faso421596eec.0
        for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 05:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779883838; cv=none;
        d=google.com; s=arc-20240605;
        b=PQGdryUcg4VDWl4x7Je+KIQ6A8fxr9s5piEuU2RScHXhInwAOEYMYOXUwrGr0RZwFs
         C91Wni0Z479GmeYsc7BDOOntNnU2nyVCqmW6vGRiVaABeldn0gUV/ARcVtaKYxE0A2Pl
         zSIqzg4JbjhCP7AsJh6dyVblyu+aaY6vfBmAVdyfgXs6wbpMojELwYFvIoS3oByl7XVQ
         Ed3b1qdcbzJo4+bVZ4Mc8SeCGqLM0Bf81kg3fI3g51dCeqzKukET8+TCFo+ZvToWOO4g
         Drnf9k1JH9xxhCy0+DUCQaFUh5Gt9UN95X2a4BIoIe34UD/MPg9kE+eqdpfRZOumQOXt
         3Pug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9SMvJts0+Ko8/KsbmBYJVEEWqO8MvsW6A3genso8CbU=;
        fh=st3zwb44ralN6ocYS+0kaohdB0Fn1R//8CkJL/Gbt10=;
        b=ge/ac+jv3F1CLMPCtUlwUcUklYCMFjVF0G0SzHFSs7aUmIJw0ZE/EY2YKbcTEMF2wB
         43E7bCVmHQyrd6qcmlqB2PDBNZIBqWcnzeHN22dgeimw9TZiKzK1cxpKPaPDjt8PuFZt
         CZMc1oNXY7JW0yyDxsJ+hhAL7U3ghZxuIqs9Fcfovi1Bqrg83izU4/Yppv+JPxLaoPHj
         /9GIVaXU0Qm+JL4ccToNQ0hZeh0dCE3lyOzRwev7/0VAsQj7PpcIkMxDTXSv7mWRN60m
         1aN8cbkbr0ob3Jz38U6p7l8m7FtHzchmhcadQrybtnCTCpFUeejeERxdMSD0PPiXR0t+
         jXyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779883838; x=1780488638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SMvJts0+Ko8/KsbmBYJVEEWqO8MvsW6A3genso8CbU=;
        b=XjSt9NWcEEtkR6Md9py/ePCY6+G7eTbNZfhy0HnJUJlY+LNmlKUEz87zGpLU8qy2xd
         0bcYhMhhcmAzHHiVvh3W0VQrFpJS9R678SvwknCwcJThtgEQ6iukwIeVrh32odrx/+Jv
         /RgFuVgTFBhXzt9MkQSx5IyL+OfhV3PyY777D3MHe66RrZzCIqxV7sQQhJZqjmbbhbFd
         DMfXtVNheID7ga19pq87beNSB8BZWep9GK6w1xfkVbnRYuov0Eozc2ybT/U1n8GV2hFv
         Jr1OKEHjomRtSrM177CbVSaBSeisg8z0h6yC/mNaQyDNRQN+k17EJVHPEsdHAOJ69V3u
         s6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779883838; x=1780488638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9SMvJts0+Ko8/KsbmBYJVEEWqO8MvsW6A3genso8CbU=;
        b=MircT0JD838MpiTaKogG5jvep77veoDmU3cTyUjm7m0uvhWTpQsfqjOJg+7LC9EfCa
         OxGX831o78WA9MME1kxR7vt3LfSUWX4DRkJFn7G9SpL/5gDm3FXoefUniGNQc9HaEosy
         I+9A8thdsgoMmsHrHuJeb+TCuEhNy+lAgfxN9UPZsJK2HO8lvDkLrnN4TQtix9M3++At
         emTnGQVwhVZENEPAI2GNi15J6Pixu1b6p4/+Fa2r2X3Edc3jXb2jslgBiwfeQqPjtSvI
         JJ3YA7Uc7XCchsZbN7BWpX4K+RsRtVG7XDYwe06BZEy8SP3G0iv1m6PPFbCoA2THO8o2
         3/gw==
X-Forwarded-Encrypted: i=1; AFNElJ/bIDXNnL/YPjm+gAIy4cdzT7npknTO5Jc6bJDyCy9qFarroL5zQawia39UoOGEY7UGntvjJKCpoBxH@vger.kernel.org
X-Gm-Message-State: AOJu0YyXSLg9nlCMTjvF4p7EeblY8GyzTotHv8brVen/B5p5rkT4/gVT
	5Enneg/Ur1q/Q7x0zyY63K+2IfM/XXVCiM7aNUQVlBEdH7vAQgFbmgtLOf4IGgEqiSdmf8GHd4g
	VKbs+V7JrNCfQ8oZ5YFtKqiY5BMh3C8I=
X-Gm-Gg: Acq92OEik0YH6GwuR+T217HKhd91q9ZVUIF9oGEeeNE2e6GPUqKYjfvCnoPqCFS+JcL
	2sJ23BmD+hx5VmPHVEjtttMytXoYafPpjr5sh5/3ESAQKBX+h/yZKnlLR3/P/8M8VHQNwmrh0xf
	KoWQ3fxmG2xoL8A/mpg2+kRwTm4UK28mpvEMF7U8e3aSrlITeF3yZjS41pC4W5XTkWJg5jJeGZc
	zSyN8WpW9sZ5JAQy6tpo+YZ1iiIQ73E9j1PMhtBVLvxJXy490kzBmKWRrSh/SoQjGnpfMKVgHQX
	QnA91B+Y+3K7Y5Qq3xe7zq7zoe/bJu75LVP2FN8VFIcMHzMPZ1GJVrWS/81hgOd5AHbz9KXn5AU
	KIYEAUt14ZYAYVtSO+bVS3Ibvf1Xm1MRZaw==
X-Received: by 2002:a05:7300:fb8b:b0:2c6:7f49:a840 with SMTP id
 5a478bee46e88-30448f39539mr5268008eec.1.1779883837507; Wed, 27 May 2026
 05:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521165622.279953-1-japo@linux.ibm.com> <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
 <20260526161312.19291A8f-hca@linux.ibm.com> <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
 <ahbJtRzeJUqpj3Ux@google.com>
In-Reply-To: <ahbJtRzeJUqpj3Ux@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 May 2026 14:10:25 +0200
X-Gm-Features: AVHnY4IOwat8wHLs5SZ_NDcVxFuUim-Hf_Ilt3-n29eG-Ytnw8O6D6NcQ4eP7VE
Message-ID: <CANiq72nATtptB+hOHAgqg8Zn_mzUSPRZUCXxnL2j0_yNqrMgOw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch glue
To: Alice Ryhl <aliceryhl@google.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Boqun Feng <boqun@kernel.org>, 
	Jan Polensky <japo@linux.ibm.com>, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 12:38=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Based on some very quick research, it looks like enabling the backchain
> target feature does not affect the ABI in the sense that mixing together
> object files with and without this option will still work. If that's the
> case, we can add this to the list of known target features for this
> target in rustc, which will silence this warning.
>
> (If it affects the ABI in a breaking manner, it needs to be added as a
> separate flag rather than being added as part of the -Ctarget-feature
> flag.)

Yes, from the different discussions what I saw is that the issue was
mixing it with `-Zpacked-struct`, but that is already rejected by the
compiler. They also discussed whether it should have been its own
flag, though.

Cheers,
Miguel
