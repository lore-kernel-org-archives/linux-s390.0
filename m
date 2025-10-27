Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DB31158A
	for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580443; cv=none; b=GvmWVJqzTYJkKkKNGxa79Sz2lvLpZzw4WIqw8/h62IOe/ZybYA95YM6ZR6YkqWfWGOeR3melORh0lowwFHtZeo+PBnT+zx8m833+o77JFMAHDlDWmIIoqCL+kIy4OKvWlhm+BCEYSiXdMWzMm0pQbLVeqIgdVEkR7OxbLvTLdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580443; c=relaxed/simple;
	bh=3vakKTarVQ1LmVyja0G1VxJygmwKNqNAyvUgHSG/kHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqeYN+EmWhZ+B6TiArmncXKiIPuZC8krHgKHTMARN12ErdFo5ap+pHk+RiXLuFr0kETd94EaqyX1nhLsj99TEli4GB5G1rCcsXb9+yK/9prk3DsR94AiHpIyWS4OMAT6X1mcIAq2NGiqL9S5ZWkSWTHTfvR/QyRD3XNyYjgaapY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QK1LBX2Y; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QK1LBX2Y"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6dbb4a209aso8430766b.1
        for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761580438; x=1762185238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lyo3P6jUrO11oV/07r7VEk3+sHuM/zfcTZIIBqJLkxg=;
        b=QK1LBX2YQDM5Ph6kvBRazX3BNvtd3Pc+KE4rorNuhqAh/aAEEaVieTdt9Zav3Tew+2
         fOW2qXur1AznrQYUIvCjfKWJvqsMvDr24+H3M0gscNr8164lgl9AMRbbxxTOKrx0XqJH
         PfKimbmoQCKBCwRAncJSS9Qmnqw10rhKjnbrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580438; x=1762185238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lyo3P6jUrO11oV/07r7VEk3+sHuM/zfcTZIIBqJLkxg=;
        b=cuTKv242s5Jfw80SnqlBzhgrPb8A+9pD6SlvCi8h+QhaSb/6BeARsnSSFhQ5ABO3/z
         rl5iqNIruEnSnfzUAHeQ9qInRbsNzy6r+OccJCT57mZY/sjQxEyK8V4tGumq2jZpcssf
         /mukdtlVht/ex5FvD248qihg8ZpbE8NlL7BQtL0QERW7mp6z9Btbnx0Oiosgh9dUGR4Z
         2dt0NAJ0RqX9V5QlEbZ9S97H4eLWB1V+Hvsj+kvl9mtR4oQUH4Ze2OqIewZU7mAA2mPQ
         sYedjgBcjNMpaUcQC5QdmXaR+3ne6U2JoaU0TrZ0K9+sWf0gkTsAO/uwzcTeTLP1h87M
         CyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXma23pm0//dsTLlpXEa4WRcoK3cDdGKsbdBegSElGgUPm3B+7ZVduo8F1qTs2jJJhTb09bidbie6q5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pA1/A+d+NQ/aK9K4DDy7HQJBG8M4pvuPe3g4CT0jK5nYn3Qe
	csIM1yvXljGyjXeHhPVFszpsjBmjwjqrZdE5B5dP70BkzMkOGUl+65sUfUpyx2IDitjF6+s6wmx
	nQ5e1jyc=
X-Gm-Gg: ASbGncv34kd1B5wySFJTOy+GF3uMCRSOARxw0k5OYtvUzGJvzdL9vhp4oluHQ6LRcZ3
	C1VDFf2LmKn7FkAyUe4PqJgPglM6bWptIWxfY+QuMFuK2/UVdxsmqaMXSQ8EMG4Wsz8/XXXUgzX
	EcCgLArP93PzMAohY0nWC5wpNof1PrC6BYFZJXxZATTMpyBPV1mmgVVYAzsylGclsWIaUjnXuZ4
	A8zNrgCQtYkleGtpE+kKVlMZp9WmAA5gVNO1+Y1X01SHLHzUoBggF1gBQv4ZGuAy+pMxlEUJLGf
	3iZr5Z0KNZ1AqcgL38aOLjBtA91YCmehn4CUkfd/zBYDYjmk0j4vX3RUs0drL7foD269LJAo5cN
	xzMPVQRp+jEFVWt+zMCZoYzfqv2sGBkTeMxnC9/CP/KxhgAbaDPzu5d+ebxx6oqG40IlNeZtVv5
	R6423XGoSnpoiDUMIzxgR/XoLkMI0LRrUaPDENsGiFCNTGEMOy+8s/fhBPrObG
X-Google-Smtp-Source: AGHT+IEEjGadNEbxRt+31kHGe0ViAM5tt3VJF321WEjyerU6+HtjUPaYFgbI1fZIh6l34f5y2K3rag==
X-Received: by 2002:a17:907:9629:b0:b55:c30d:c9fc with SMTP id a640c23a62f3a-b6dba444085mr40198966b.11.1761580438587;
        Mon, 27 Oct 2025 08:53:58 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853e5138sm797423966b.44.2025.10.27.08.53.58
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:53:58 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c4b5a1b70so9196251a12.1
        for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 08:53:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmwiygZjKGAOTXas/4q3BinY82LZxMypfdPsEMVDueBH1dv3B3db/opydo4Vs6G9HKLYb7ooHYYjW4@vger.kernel.org
X-Received: by 2002:a05:6402:4412:b0:628:b619:49bd with SMTP id
 4fb4d7f45d1cf-63ed84db9e2mr369134a12.25.1761580437926; Mon, 27 Oct 2025
 08:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027083700.573016505@linutronix.de>
In-Reply-To: <20251027083700.573016505@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 08:53:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZ0RdDzpafUUduCn3gOVX3a=ZmGOw7wu1s-jqe8KypDA@mail.gmail.com>
X-Gm-Features: AWmQ_blZNXFTqWGx07mPO-qNDyYJc9sRx0MxijvPg_spVplnaBKcigb1OKRcACM
Message-ID: <CAHk-=wiZ0RdDzpafUUduCn3gOVX3a=ZmGOw7wu1s-jqe8KypDA@mail.gmail.com>
Subject: Re: [patch V5 00/12] uaccess: Provide and use scopes for user access
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, 
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

On Mon, 27 Oct 2025 at 01:43, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> This is a follow up on the V4 feedback:

This series looks all sane to me, and I think the naming etc now all
makes perfect sense.

                  Linus
