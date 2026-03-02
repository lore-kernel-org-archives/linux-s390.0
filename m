Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8244266AF
	for <linux-s390@vger.kernel.org>; Mon,  2 Mar 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472411; cv=none; b=MSvVIuJ0TlorPKUjqpiswP0iUMxFwt/N/sbexk24/dZp7GbknhtoAa/4Fz7PMA35REOKiG7Pv93CRMhypGTF5hOtB2ZY2F5PriPyXXYZssEV6NXRQYJD2xIFKyd92uNyiChXc8G6O/JC8h/4xhVlp7Dn3IU808jCxzW7h6L/tUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472411; c=relaxed/simple;
	bh=DX+xELAl0bpiVrjGYaZkMtgmkQplvgyN5cOscxnOeOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gM2Rqv6bYp+r2GUVZ90v4Djm/eE1eC+3mx8LdUCeXZJBlXBzavnLIcpM+o7mLer8DH3sLDNVaNcU0jTku9Fefi9AEX7NTcneV7o5/Irn+u4z2bcvdzaLqq8Dwzy/mxKrBLeSI2pZ6nN9QZSWgMlflVdur/Ex6anxsDFeNfQPJT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GywcdkTC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GywcdkTC"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65c5a778923so7338328a12.2
        for <linux-s390@vger.kernel.org>; Mon, 02 Mar 2026 09:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772472408; x=1773077208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NhM0U/KytZp1XoP7N4M9fAB7JNIxjdmFkfjBUQb/l8Q=;
        b=GywcdkTCgYc29qqZKLrNkknf6Pvzuvc9BWLEUjXLpxErH2k+rRGX06DcLmDP2t4aV7
         KKDkRsQwzcqZ6v47ltN6CeaXwQfXLaNGcMNT0bM4BxGfEhn9oRxs+GATyUuI9ogwHyPF
         v6isvSilwaT3aLY0XgX5kshzPoZFt8honUHe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772472408; x=1773077208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhM0U/KytZp1XoP7N4M9fAB7JNIxjdmFkfjBUQb/l8Q=;
        b=tvUcUxpRc2dArkCkaEacbOkssaaXUW89RbojxUyHN2+mycNi6vF6bP0olnsBZ51FIe
         ZLX0nPtDyeyiOIuKqpfXpxP7u5uJi/vJjTMI99vn3VJwYdQuLlW4d2NI2ct6drDUcOm4
         lVlAF96wpkQMRnn5ilNy2+DrbncIOH1HLNdD8Cj3goMw0n3JQGhYyi0h0ewfAljL+ZqQ
         iHJAoiQ4q107SII5Wujl10wkP7Cgm4p2z0RrV6kjOFbPtA9HHxmBRwR9Lk8UZ+FBwf6U
         YQsMDz8NTZp1xLqwaJp/P+cNf3ZR39vnCmNS3PTAijmE8V+wK/O+UhhL/jTX8hsiHjvB
         oFiw==
X-Forwarded-Encrypted: i=1; AJvYcCUftjsrqwecznzGOWkULnjlrh7A4csnO2Stb6m3LLDYdgFzImEmVucyDajkqTvdansJk68PVqfk0DI5@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOPsnElryV4wF7v4XUuRs4uVQjGsQUO3CDr2Z80NBMwIvvo4h
	YBhaRcEXMTxXH4negAuqMdc7kC0+bPlQjQgWM4gnlqTvwrLz4WPdjZ7MUqeynWb3++wnLkZeiGB
	aPxHefqKuxw==
X-Gm-Gg: ATEYQzzReE/g+8yTam1gulcxVgidIDaixU1e+qjjr+0aAOGWEF7Xms6PImyoggXzlQp
	mouj1AfS9RP7LStAPZFXKLyUxcUxdDB2YvpyBxOIL1r52oMRpBSN/VUuWzuia4bNmjJvTdA1hJ/
	8mb4Djy9PVOaqzifNsRsEusWagk6B37ic8TifuyXJvEsLzZZ88xHrpl/tYXSoSLXJc/rjXw8FeZ
	+grkEugJj9Vsa+39QvlgepKmDwgDh+Poc3m1zPwPOecoL8GI15CFX3kjsJXzo2tuOm6UMaUn1xz
	Z9OMW8ejPbOxdMgOLF5ntBEWJUQL6Aj9mBnEmSInPe2LUNuFsbf12vjSIH82oJ9cnOwoIJIgLhn
	bEDb4gwkAs7DZyKTBs3n358/D0J3GG18f2ks04XOyyExhuo6I+wnT2xcVzg+jgS4w7z6QaNvvFc
	kwMPOBMySk6I7XtxmTq8gt1pGc1+xprvY95jVvmTHjLFhL3TJVEf6+L//QSiHj3AQnRNNefamk
X-Received: by 2002:a17:907:9408:b0:b93:8995:8f3a with SMTP id a640c23a62f3a-b93899590d7mr543440466b.3.1772472408011;
        Mon, 02 Mar 2026 09:26:48 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b93973d3ec4sm290437766b.66.2026.03.02.09.26.47
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 09:26:47 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b93695f7cdcso540327966b.3
        for <linux-s390@vger.kernel.org>; Mon, 02 Mar 2026 09:26:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeEnxvUpDHLdl6V46QuEu6T3U/YDSHW+/WoYgS1povze7i2ErZl11ZVLquaD4CDKANsk7naRB4pEfJ@vger.kernel.org
X-Received: by 2002:a17:906:6a17:b0:b83:1326:7d45 with SMTP id
 a640c23a62f3a-b937b42886emr757779066b.32.1772472407269; Mon, 02 Mar 2026
 09:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
 <20260302132755.1475451-2-david.laight.linux@gmail.com> <e8a688b3-97e1-4523-9a82-8d9dd16e3d90@kernel.org>
In-Reply-To: <e8a688b3-97e1-4523-9a82-8d9dd16e3d90@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Mar 2026 09:26:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKWi=j_xcMBAi2Hkuut6aNeqXTwOFoMGkHfDA+3WXsgg@mail.gmail.com>
X-Gm-Features: AaiRm52zcwSKl-2ZFc2XJ2K-Xgcl3ar6vYfBBv7z9Nop6yBvMYBvRXM6loWQHmg
Message-ID: <CAHk-=wjKWi=j_xcMBAi2Hkuut6aNeqXTwOFoMGkHfDA+3WXsgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] uaccess: Fix scoped_user_read_access() for
 'pointer to const'
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: david.laight.linux@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andre Almeida <andrealmeid@igalia.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Heiko Carstens <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>, 
	Julia Lawall <Julia.Lawall@inria.fr>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Mar 2026 at 06:59, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> Can we get this fix merged in 7.0-rc3 so that we can start building 7.1
> on top of it ?

Applied this first patch. I'm not so convinced about the others in the
series, although people can always try to argue for them..

              Linus
