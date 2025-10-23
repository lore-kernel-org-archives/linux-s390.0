Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09F26FDB2
	for <linux-s390@vger.kernel.org>; Thu, 23 Oct 2025 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247596; cv=none; b=VroMdZSSqj4OlU7J6GyhNllRrfpUnFN7pvSciv8O8AdlDTj46b0DZJiqDzK5/Ba8tRthoYP3c/rOZzPiDzX1G/btI7I4GwcQPT+FR43XqajLm+X6AKuqDzRMroxXSRcBeWiPihHG3kG17N03pA27+x4sueolqFYU8JDsCK6e45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247596; c=relaxed/simple;
	bh=0g5PWwg2p6TKfCHzkJ+Dwpx0TfIIseEhNZqQ162TaLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quxZZrQdnUywCfiaZIUvNEeccRwtS5TlWKr3OqBqOIzqDLvlA/xAnQeDjYiU2f4CHkeYe6CX1GbJGD6vSgXGDMJqVAFu+LVgQd9aB6iGsE2oFIEdkfKYUwbsua+cCvCYY35oYYdSnGIYpJxiu3FQuRZXUyfPZRw2Xq/S+1zuj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cLoDEtX+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cLoDEtX+"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d3effe106so288823766b.2
        for <linux-s390@vger.kernel.org>; Thu, 23 Oct 2025 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761247593; x=1761852393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+nka1o0UKTB6+YPro/AThdj4Pv3gE7VXwEkULP704E=;
        b=cLoDEtX+hWb/6nV/I6/LvKVncb1ZH2oX4QkBvG0DaBanfJYNCuRvfAYiiyvCE6A+Z1
         QO4tvrbPi1S3Bo2QV+zyIdSpgXvlY/trHallm8uNfJ8HEv5NFhNxqUGGQF2LR7SOBCab
         E3/tfhTYb/jrD8ko8eh9st8LmTplig9PhWQdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247593; x=1761852393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+nka1o0UKTB6+YPro/AThdj4Pv3gE7VXwEkULP704E=;
        b=qaYsjvF3b5yPmZ14nRUKaJSX1nzGfT0hjZZDchIqnds3bd7H7ILbNVWjGMMWkNIWRe
         3YREOfFq0HTz4tgW/FyKRVKc+L/hx3puE3UwVF57KjFrjQMpGCt6lZPgJefR/aMDX4WT
         i9jVIb33aWO6Ws1j9Nlj5zRdb+AjWNz+1Mc5YLbmS8FgQktZ4xxV0m9/BWq8+XxNZHDF
         1eAgpf/bzioYOt1d42sJ6Ir3AmULOYkbAXzO2bfk4JBeUSEBTwkeBTMCHOp1u7ZzWAUv
         Z65EHwXxrv0PV8H0SB8UyOGTYMwKR0J+TuPz8XaZqZLLeUW7nEjkUZQqVNqaCVW9isXW
         Hr9g==
X-Forwarded-Encrypted: i=1; AJvYcCXtB1HDc50whAsjzwcBo1U6eaXPDsS5T/CbSsKTDsTVYLHEggt4VBK+bYe2Kzat8t0cczjUB4kQAmLi@vger.kernel.org
X-Gm-Message-State: AOJu0YyMa8EmFZgiVqsHtgcapzhilAaOc3Ukr4oINmYzvbUTJ8IZetjB
	nAP+KIZoejMXJLFsdaGU+HmuRFe5zajfonNjLATd6ZkEdSbGXQUix+IY01Sf3w013WNPRbD9TGV
	KScetdj/lkQ==
X-Gm-Gg: ASbGncuMWDTIP5Ot3iiIt/Dft9aClTavitxAlWUWg2WAgIWV4YC9rUzIdbcKEA4bC2v
	2r7y2PqytPxggxqr32+MKT8Z0KYzv8xoksyVTBjiz0LVNilyEcXTz1/MISKVp3DO1esuFPR2AUx
	TeEslImvB7EhvRRUrS9Rr1ixTkyCfoMmzEDO5menq1iwn9b1uqaNmvKaFP9uLRdHrv27/aXxEEi
	7fSUQ9LizbKeWILXRYx3bui4oBF+mcgQ62vc9qa8QvotzF+tXsI/Bhm4/Dg3RmM1Ezeo4aRx9rf
	QpK4p4h+sJASRZFNYBZEEmJfQG3RNOPF8Dgp54BPiMCtbF65TmqnmGFPbRUlwwZy7u+SjgwKoWM
	CS6GahEbYASvsdKbum86CyeCuqNqkSxP7fLNOs0JQD7UPATp9Dy9i6c0dVU+/xW8IXTfCrxj+5c
	7siRKrKuSBhyOojBkCWDTcNP986YCGOqmH96BQiABJNlNAQlD3yA==
X-Google-Smtp-Source: AGHT+IF/PV7aw68/BDtT4xdp8PeFY9oU7chHyPICBDf4Hvs1/PkSxmurnIRMiwamF+CVAlleX5GbQg==
X-Received: by 2002:a17:907:c11:b0:b46:31be:e8fe with SMTP id a640c23a62f3a-b6472c6194dmr3026539766b.11.1761247592874;
        Thu, 23 Oct 2025 12:26:32 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144d565sm303578666b.58.2025.10.23.12.26.29
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 12:26:32 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso2756665a12.1
        for <linux-s390@vger.kernel.org>; Thu, 23 Oct 2025 12:26:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVR+HPm+HTP8qcm1tQQVLcSP4ikGG0q7+wnfdI/0+WmmXLn83aNOn/h562iW5hTkLvlHVWfqUrAshvk@vger.kernel.org
X-Received: by 2002:a05:6402:2681:b0:634:ba7e:f6c8 with SMTP id
 4fb4d7f45d1cf-63c1f6d5e1bmr24956720a12.34.1761247589536; Thu, 23 Oct 2025
 12:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022102427.400699796@linutronix.de> <20251022103112.478876605@linutronix.de>
 <CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com> <873479xxtu.ffs@tglx>
In-Reply-To: <873479xxtu.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Oct 2025 09:26:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
X-Gm-Features: AWmQ_bmaCluDq9_Xyq5CJoakX9a-PwfYiYDMZ1KnC-jDJR9ceAw_ALWfx9Y5hW4
Message-ID: <CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
Subject: Re: [patch V4 10/12] futex: Convert to scoped user access
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 08:44, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But as you said out-of-line function call it occured to me that these
> helpers might be just named get/put_user_inline(). Hmm?

Yeah, with a comment that clearly says "you need to have actual
performance numbers for why this needs to be inlined" for people to
use it.

           Linus
