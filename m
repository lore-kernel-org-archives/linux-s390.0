Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064E342CB1
	for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660302; cv=none; b=MXbZJzXTmZvPCZmqd8s5RB1dYnNUjOIKcx6RdmDhCCGJ0tnPlyl43zTj6cX2tr+GCkB5gMGNzK+eESM8392l0PZLvbxxpdMGpTIeKpAB9VuifoYSe6dRJ3rhnhQhDGTgyghcGQLXAEt9Y/KknDXh4XAF6OPDaBFQj+UdTDyF/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660302; c=relaxed/simple;
	bh=XJNXAFxZiK88cHz3NFRWbJYZtmI5vkRXCxubdq9iJNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQbRcsNAKnAS8v4qfzPUNMmCdFWBCtNXAIAf93yD05R1CqYSsgtAeVM1kh/GvzYnk58qn8bjiV+ZKp0pvF2esv9PpRK9Ok0A45r0eTFC4BsuYJE5z7PlxmP5eQSk8ER2RwSrPW9J+b4Y+id1a+SjZYJAVnwVQP2yWqnFRY2HTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkD9PecY; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkD9PecY"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d6014810fso60014077b3.0
        for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660298; x=1762265098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tV6lq40DHC8JcmNfWL6yF+Abxx6Ldftej9yA3XYbJaI=;
        b=LkD9PecYZJCjpN81Xp8B9YuIdXawRmUkLPFYl5OV4oN411bhpSHRDj0WgIRDVgMA+2
         rt8yeyDnCpeG1F6Qu4K+Ns0oYJuNmuEPjnA0NJR/eAvgiccf9rDmkXG+Cbkt8i3+FQiW
         Hb30KZacsgjYXqrX1++nRbU3aofjx4BHnkH0j+ZBZBobTJs3s+K9BZjYsq4du/CF5rDs
         JfLL3A7auKDgK3fsnJplkRf3hQu0C7JUt6cCrTDaMrjmsM/oVPK9kgxXM1Df+t4pt4Vp
         xf+rGMhZZuDHRtSse0fQUp4svRhLOC47JpJv0OMcMRLS7bte+auvFiZ8c3SXHvP6BZl3
         D+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660298; x=1762265098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV6lq40DHC8JcmNfWL6yF+Abxx6Ldftej9yA3XYbJaI=;
        b=ChgM2eMHr6wZ1jHgGD/Sy8kGwOkoherQtyKUNgdVUlt2UxhzzSa5TUdhmQdZjjyOaR
         VFHuDp1oa++lMPr0BIB6DEsiq8vEtgHHL/u0A+my7vGGXnsC4C0yMoFb+fLSHxpCCqbe
         v8GnRpa0m+9ijv/xFP9BaIQEN5bzO5oPQLSGuH5I296SgHlQMzxzZTCNc3rUtOIUyZkv
         UkHLHmfDzT8JKjmOztOvaPg1J8kmoqNgyQy4EiF1+2R/S4gkZI94zfFN8R66arDsv3iD
         onR0fA9owIwBHrx+0NSCdTLsGTxuXOn4KdyleKd9uc5OaJbs8AKYsqaBCynbkA8Qvtd/
         IALQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn3yOMqzYefwBwdOaj7gkgCVC2FW61GF4SP+4a1rntA4TJn1rkilSFAZcGm6xkyCPeIiK10mH22w2Z@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbd99w1LQZevu8YNzSJ8r6l4Oq09yyuv79TXnK7C0zHxaaqj1A
	4m/VnqphQ818igY7yLHqxntHTHg0snIeys7sbiaW/wX931WjECivPyi+Z/5dOeAq/CEpg+Tdj4f
	a7kvV3tlhcYf+YOhCFkcuHaw5zIhGjyE=
X-Gm-Gg: ASbGncuDdGmph0qnCbUyq4n7nKQlxYxTrVbR4EVnEy3Ten9zMQox5vSgW1engQQ6h70
	Oo9NvyIsdKvo3yG0pl+1C1RGSiVUx3e20eFPqVpmjGvpjXeALUqLp/HPNFgA8frIgd/5td5f1ee
	ITfonBu3e6k27C6xvSQWeS8DgK8k+j/owK2cILblDkcKKHm5jRoo+BedjqMFar+Iay94Cgh9MnP
	8h/7IAMnuN9odpYkV9c+z3By569khejZEiClyW9L/ToTQCYJQsOOUtXJPyHiBifjb/TGgro+Oum
	ZVvq4yeN1CtiaEAPgw==
X-Google-Smtp-Source: AGHT+IGO59IsEPrMaZUmuz6Z8HqEjQzA2Ntsc7bvDVyVXUheTpOGkWA4zrFX+wmhIbJUO+iBKxLOdRdY9YaXu1dEED0=
X-Received: by 2002:a05:690e:d83:b0:63c:e90c:a6d8 with SMTP id
 956f58d0204a3-63f6ba849bamr2974242d50.44.1761660298140; Tue, 28 Oct 2025
 07:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027083700.573016505@linutronix.de> <20251027083745.231716098@linutronix.de>
In-Reply-To: <20251027083745.231716098@linutronix.de>
From: Yann Ylavic <ylavic.dev@gmail.com>
Date: Tue, 28 Oct 2025 15:04:46 +0100
X-Gm-Features: AWmQ_bnQq8Ze7k4D-80utHvwT6MTXau8I1_bRZ4nLy6wJZW1-jMkY-uZGE3OIrk
Message-ID: <CAKQ1sVO9YmWqo2uzk7NbssgWuwnQ-o4Yf2+bCP8UmHAU3u8KmQ@mail.gmail.com>
Subject: Re: [patch V5 02/12] uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:32=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> +
> +#define __put_kernel_nofault(dst, src, type, label)            \
> +do {                                                           \
> +       __label__ local_label;                                  \
> +       arch_get_kernel_nofault(dst, src, type, local_label);   \

Probably arch_put_kernel_nofault() instead?

> +       if (0) {                                                \
> +       local_label:                                            \
> +               goto label;                                     \
> +       }                                                       \
> +} while (0)


Regards;
Yann.
