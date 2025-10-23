Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235028643A
	for <linux-s390@vger.kernel.org>; Thu, 23 Oct 2025 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254096; cv=none; b=hbchP3fAqGGldvWwAPd184lIys0QfikTuBq4FABzWEMx0vdXAM0ZkigaGm2hCyzWk2Ka09SQXGN5Yr+SO9H3tK+vmQfatxRbFwjUFyBOnK28vPSg4dHEQ8CvHl8ira/jUKJcrmMBiZuwgdR/t9opi5kqWImZBRSNpMh22FlQ0ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254096; c=relaxed/simple;
	bh=gr//hXY2CACNJmuey8RcSt/nzmsO2m0/uxqUGfrhxmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3dIH2KHxYCdxsJpJndd/1Vv7MwR3jAhry6XMOchLMoXvBZU+t9XINOvBIM3SR0n8wBv5u//4AprvW+0phWRRZh9X3F8wH8XZua0DUTWkVo9OPQ/FawVj6m6+f4QbyT7iJpJBCCCubHbTxFirPKJv3IYdWa8T3TeHO3Vzjp7umE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtcIlouC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtcIlouC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475c9881821so9510055e9.0
        for <linux-s390@vger.kernel.org>; Thu, 23 Oct 2025 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761254093; x=1761858893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6sEiHIDuaPc1r9BapkeRLwxlBj8uKP+Q15MeH29iBY=;
        b=CtcIlouC854KexNltOZckq+65YjcU0ojEq87VP6S6IyOoSBaSnYdqRzFbID0iIIrB6
         ITLK81ilE4vGCSV9Z/iWzp6HA2BXzh8a82GUuXjZQXBgG2ULQPeEEGdlxlX5mAqSe445
         kDVowmrP1SnntrA809gkbekTTdlr4CWzWw2ADy7mDAhhSH0/F/psWIqmlwhvwugOZOq2
         MG4OuZ/+NqVNPrNsSU1/pvUdjWcZXd1C4MvjFbR7h10kKlN6tsksa+zg677ulWQ/Koqy
         CjN44C97xzY4hMNLtqD2SBlSC6yZtl1cJyW3Py6Ytc/BPIIttcoAGICNtGBu7drCflS0
         kzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761254094; x=1761858894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6sEiHIDuaPc1r9BapkeRLwxlBj8uKP+Q15MeH29iBY=;
        b=CGiA33+NYkjAOdyglbDRucAW9anvmh7Q3BPoSbufyaufg4rhJbydZTlGrnu1dSTbuS
         PWc6/qm2246mnBsCQ/FjohFOppyYeAa0nJhpRm07q4224QtqjV4ZMKX5h7kB7AhVbYwx
         BJX0VBGEnQRB5wrDaveHDwLDjqkCXMvcM0gjP22cVQcZt7+N0thrDNAvFsjDKaEji8Ce
         IQ+KyTSHb+hBbcjzPz5n+LjwexUMhFJuc1qrcBjImpkpMZppPw3yaH6fwNcsFfWpZEDr
         chpgkKZcBKwSt8Wra4ob7NswF46ICx7mgUuCM2MuXneH5Akc2pt7daSQzGxQD6O4zxCO
         DYHw==
X-Forwarded-Encrypted: i=1; AJvYcCX6ISeMLyKw10g/mDmZ5HO12JuHxpPNInWxKtNXODBMiKu6KndXl9h7m6Mx3mfOcHykEXsp+hy3UaNi@vger.kernel.org
X-Gm-Message-State: AOJu0YwPM7qpJ6D/O/bGgMwHf6aPXIV1sXe8T7luZ8Iu9eb8iaFlzBiu
	npKtqSIb5PNN0PrgXkvlwCJAhPmbYrQjBnZg22KsXyqtWrnXI+jCJ4Ys
X-Gm-Gg: ASbGnctU7azvEBryIIzAAmoKnjRNJ09CmgNQZOv8nVuaXoJKPaYSq+qFLjW2PekJX9+
	CRkIjDNcU9cS4f5X9W7cXjhkXjNUbnDzmm/Rg93+0/5PYLzJq/K+qYMDm9meC5SbqZAg+CRGWjt
	whYcx5xvV9fecDbBpso9HNBsQr8BVZ+J1QCROi7b35Noq+Rl6fLTFNHP8kdvFG+wvkNGiheFu5X
	gR2xceKnSYX+c82H65YptXGqlU2mFPkanciKM2kG7E4ZS/aNPZ4mIAaP1ARpVw/eouRjgMkTLJw
	i2JSasMBKPe61phjkEwEdyS+Scnm3ZHIIe78CdHZJ3XnUyLammPGEdK6DSzzFV18z6KDeL7VyRE
	U4xrN201CwT76mlbVnidkfMtOn3SRJjFzMYRCW+FSuN6iriwSebW1AGM96RrOTfWY2dJtFBnQnI
	+npZQpNBRQnegVFRETnulBN8km+Y/GnoONSJmi6gIehw==
X-Google-Smtp-Source: AGHT+IGk8eEDWy3Lb1qhGeYZ8N0urG/YCIu8xY7+WZCUmyVKdYxjr9Zc6A6l5BFcgm2g7Vw9SfAVXA==
X-Received: by 2002:a05:6000:1446:b0:427:374:d91e with SMTP id ffacd0b85a97d-4298f545550mr248975f8f.11.1761254093423;
        Thu, 23 Oct 2025 14:14:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897ff3f5sm5951290f8f.22.2025.10.23.14.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:14:53 -0700 (PDT)
Date: Thu, 23 Oct 2025 22:14:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, kernel test robot
 <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [patch V4 10/12] futex: Convert to scoped user access
Message-ID: <20251023221450.1303003d@pumpkin>
In-Reply-To: <CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
References: <20251022102427.400699796@linutronix.de>
	<20251022103112.478876605@linutronix.de>
	<CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com>
	<873479xxtu.ffs@tglx>
	<CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 09:26:12 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 23 Oct 2025 at 08:44, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > But as you said out-of-line function call it occured to me that these
> > helpers might be just named get/put_user_inline(). Hmm?  
> 
> Yeah, with a comment that clearly says "you need to have actual
> performance numbers for why this needs to be inlined" for people to
> use it.

Avoiding an extra clac/stac pair for two accesses might be enough.
But for a single access it might be hard to justify.

(Even if 'return' instructions are horribly painful.
Although anyone chasing performance is probably using a local system
and just disables all that 'stuff'.)

> 
>            Linus

