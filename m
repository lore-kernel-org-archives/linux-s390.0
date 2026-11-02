Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793652794;
	b=I5SjKPDwWXow6/shHbrIKlSK48kkS1adElockoXiGGUPpRVZd1/HvRbjY6RZRuyEu0UU
	 Ff4kmbw51ZWRW7xlU/zwSzFxBO4eLHgKOq1AZSuvrNK143VaB/3cYWv+ye2zzJMOk08gZ
	 LM6Ln5xNw7y4jjX2wwC7wkQbfbAbZxzXNhW8aYUg5K4Uwf+buvemEzEfY2ZA3k+ujxPBs
	 L4Nepo0D7TLKlW2vbzho8y1gAzDf25hEXm5w8XI4dk0KB2BQiUPUktpRui/QoM+0BVn/R
	 4cVKoEU0Pg1JOVz/W9tQFKuQmWkdKTTious8n8Ms5CoNl7xsm2hbxtHJr7vWXMqPhYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652794;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=dPSyQEFnFjEwwd+bd96IR1EK4GGeg2fbRImpiIY5zfaABPjLRyY45v9HZrOfA/9EaYpG
	 d5tU7VuFOkCMOcb0s+8FotXcsIgloKTIDktHx1FCIb/fXY7sSBV7EsuHCe7HimKooYJEv
	 hc8rYo79xdLhx+4S9jLjdIenJgxkle1/VjwL5A8mEYBNTDVw+2zcfUPCe0ovRRoay46vD
	 OBqAtrG/dLdBCRaOCcbWsInSI9GN1T9Ua4LdizNRaPG2gDksIeYLE5ZfxNeLGYn0axI32
	 itrE7rT4foCoAxp0UGbX5kIqPfSxXCIqZjIET0uD0BIFPxvrNssJ92/fGiu2rFpy4aA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X7LYFy6b;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ILbC3qNV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E4606A32F
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 20:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A8E4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X7LYFy6b;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ILbC3qNV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793652793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=X7LYFy6bDlsCDbcGpVtVvYcBRa0qrovCcHcKf2gPPrbXsIZxhhYFBkhdbxuYkbIMENoYpR
	njFKbCoVq0f5/nLmllDj2VRY0iTT/x7l3NPBQBgwXJ/4ZZ4ufaeUhjhAVqo0SOu3ULmlkC
	dS885AtwgLLxTJxxf6djT/v5pcSMfkc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-OGcf4zLCNPSUHWNi3nkUzA-1; Mon, 02 Nov 2026 15:53:09 -0500
X-MC-Unique: OGcf4zLCNPSUHWNi3nkUzA-1
X-Mimecast-MFC-AGG-ID: OGcf4zLCNPSUHWNi3nkUzA_1793652788
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3ab20dc2aceso227191fa.0
        for <linux-s390@vger.kernel.org>; Mon, 02 Nov 2026 12:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793652788; cv=none;
        d=google.com; s=arc-20260327;
        b=RByvNKv9W0XAZIlSFf2Be3lZ781dFe50Qvwhi451vaVSr0hbb/mrtb66sKuHWmRt65
         rE9S7Y26EaL0rnT4Ml90R1sxfYAEnM4Xtlx8Ggz1Ok1fUQCfksTFcQ6yGD7zSwUabjKE
         G3YmMQ5g1Yo9l1BCB29Tv4kxZ99+cTlcg+PJpBrUTyEeOWWe3kvTOf9HGakHYpUzrPih
         JekdqJyBNWcdXVjMWG7Aq7zTl4vC0FDmPkFZ0VU895aB4HqrK/HXOX6zidnuyRJysazE
         mz9dqJka6JgRXctoltdD/ZyeEeqew0BeYvXjwdaHXvEPTgRkcbwtJ06SyY8a+Ug62Hck
         DWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        fh=+/jGrNPKjCyzmorPjuQ4RQLEGPyOBuPfgnCTWKXK1jM=;
        b=QW92SBKSRjaSfwo8AKySYOBJ9TTTkaQFpzjZrcMvRxxK6SvbrQPVWrkKv98syeIjMa
         dvcl/KI9QSAymILyaSWUMmHdgxehDMm62wQwPwnwp74XfxwPkUxLVIc26Wj3fWX8vw8t
         1+KmR4GjZ0vPs9K4DpIixHJgrAohDkGNuY8KJKg+Ir2Dtff5XI1EUka6B2oOraqKzVXQ
         /UkqTVTLiIzPW5RkiyXN0p97ID2veok42YFGEf2Q7aWsxUc7IulOi8U2/sqTsA70k168
         NcPKby+KfegB9G+ZqlElpscVx4MCwOGrlNNkDuNj/N3l2LF5LYeQrNkKGRd5rEd2Ngwp
         fItA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793652788; x=1794257588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        b=ILbC3qNVxcxSfLLqiEMczm2K9EWJDHjQ3jtHiRo8lvs7xOcCBk9KViZKbMYNn3rDyD
         1nRBZKRZevJudcNGThw44x8q3rGE46+/V3Lp15cYzXfiXGQHqy3zvhO0o48B5BncA5Or
         KbQ3kcHqkQQMolwwbUP9ub3434QutGVu8nmoCGzc2PCEhLmjOocqh+8d4XwIGdidYoBZ
         1xLTej5dBNXaVOsg0H9ykUYcbsfyfY1xRAFquEOh1DF007rqhduAsvbJpJIrCtz2kQKk
         jbQ0GJtS49pjk16tDcdcdHiHPoCzeSh4Rpt4Z21PkzyRrg6RuTlgqDQLYpdpsCCp4Dam
         yDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652788; x=1794257588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        b=f9p2dICbhAw2XFF9WklHwRCgvlYhM5fCVlDKrVHWe6cvWj4OrVEBZ3Lk6pIPUoI/YY
         l5SpsL0Zm/tR3iWfNHWgt0aOxH7bvgegtumR/n0W45WVs2jSlCJD99xKY6KqeqEbTtMV
         4pyepmaGLQlABMHrNvSJBvNT8ZOPn1H1U/3oCRwniN/2j5f/oEFBhUJtjUYKZckjCuxL
         QxtBzOQfAzxP2cuibDPiaaL1zrqR/im9u4BJHnBMJNsqjeIeYI+hPvY/lxrVN/dedwLJ
         Ayfppffbg/mrJUpJ+5uBFjYhtEUaZ6Q9FPHgyL3R2AfdaPi3M1H2rCohlAKZRmffibHf
         ohiw==
X-Forwarded-Encrypted: i=1; AKwUvBzztDyeu/EnuaOKLOJxGirql26zPHwLRa8eLqYil4zXhzUbzjYEA45C+qQ7DGTGMlmjATvejLhyM08j@vger.kernel.org
X-Gm-Message-State: APuU4Z/pmQWkxaH5lEt3EGBYeZUEL88bVqsrSxqK+A1q3pKoPRJ07wGi
	0vbqwVUbp3G1wALU0NNL+4u5aGjeyXeOv3OHWGZUsFPCqWk9oinu6NUsiQkYXjsWYiK5dyAUl2Q
	IgnGjc9d55CFCvJQWM3p2ZxKsnK4IgKygd5Kv1apabqgMikePOD3DOqu4e4G4MMPwatEzav99Tj
	nVpPa5OtyZo1gJj4wuc7DyN+1td/mjjkvAtXwX+w==
X-Gm-Gg: AYBFou3EP56kn5JWGOsj/bUqJ9IyYoIxtkXKanJyve7fIELd2MrpMqkelfUwqOm9d3s
	Ltf3jgbOjUHH/zWlEUrJlR90lAqhyIW7J6oC/zNV1rsLphBXIRPm3EYHd/oQyut16CxPIjMbuWq
	M0NSHYdTpjY68b1rOJO9Zr/J9uQm2bkIPZ+/5xybWyVDnjD+3pf5XPstUf
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id 38308e7fff4ca-3acb7aa83b1mr20499251fa.13.1793652788271;
        Mon, 02 Nov 2026 12:53:08 -0800 (PST)
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id
 38308e7fff4ca-3acb7aa83b1mr20499011fa.13.1793652787872; Mon, 02 Nov 2026
 12:53:07 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-6-irogers@google.com>
In-Reply-To: <20261027223847.652884-6-irogers@google.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 15:52:55 -0500
X-Gm-Features: AclHuK8pGzNf4aGPekLa6NQcs521xOugw8djA3E8ZMCjZ7yn89XzG5j_wIaQNFk
Message-ID: <CAK-6q+j-MS_5St04YFU11LG_Cjf1jOuS3q33qk_iK=7TE-iuBg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] dlm: Free dlm_ls in kobject release callback
To: Ian Rogers <irogers@google.com>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 27, 2026 at 6:39=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
> .release callback and dlm freed the lockspace structure directly via
> kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, freeing ls before the
> delayed kobject release runs causes a use-after-free, and unloading the
> module while the delayed release is pending results in an instruction
> page fault.
>
> Add a completion ls_kobj_done and dlm_ls_release() to complete it when
> the last kobject reference is dropped, waiting for it in free_lockspace()
> before kfree(ls) and in the new_lockspace() error path before module_put(=
).
> Also delete the kobject via kobject_del() before stopping dlm_recoverd
> to close the window where concurrent sysfs writes could wake the stopped
> recovery task.
>
> Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
> Signed-off-by: Ian Rogers <irogers@google.com>

A somewhat "big change" for just a debug functionality. Althrough I
agree we shout call "kobject_del()" early to avoid additional sysfs
changes during removal.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

