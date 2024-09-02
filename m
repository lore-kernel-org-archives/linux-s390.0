Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED41A4E91
	for <linux-s390@vger.kernel.org>; Mon,  2 Sep 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310998; cv=none; b=ugvATeIU4+mKHG+inaye3Uxm9B+5w6w0rJ0JaoNQPXeG2F+Y4k7p876mBP0kLl65OKdPK7KiIpWSTaWrqaQ++a3yZd0tPH4jy/KZWU9Nvnx3JXTeXs0H7guxlfJiNl2s870cLnUDDKEa++cT3A4S88Q/TQGau2/Ed+xTeK8xbVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310998; c=relaxed/simple;
	bh=CMQa/33WZzfL31kcG3CjB/U+R/8uJ/2tlmE8nlhm9PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1BkCHq0UQSzPmWWBJFH4LylWhKlY0HzFJXFr8BC2/7+McsuTj3/Tmt3862hUOWOV/hDL6KPKOJcgugFovRN84sVJzGsktkFOjT6oYAPgyYzHXX/fz42AbK/Pa4/LUDjhP52BnR/APUD3Pn899g5k3C+uJImwOZxTAt7voIu9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XJZJ1oqg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XJZJ1oqg"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c0aa376e15so2538365a12.1
        for <linux-s390@vger.kernel.org>; Mon, 02 Sep 2024 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725310994; x=1725915794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=po+MmfD4nq5cLkClRRslOxFglpMwsYkFajj19L5Hzi0=;
        b=XJZJ1oqgoQXsMkLMFKUqqoiRRSQ2DgqxELCsrkLfbRcfIeNz3uxJh3p2/Dddq/l3EB
         QB2tpf2BfHWCxX559up8p6etrHPnMoo6nArgfbcBn0vVsZUufVEavNDfPEhcQUFR++i0
         MAD6F/uRN41TEHBFp0zVnS77T4JQs3JbVbv+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725310994; x=1725915794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po+MmfD4nq5cLkClRRslOxFglpMwsYkFajj19L5Hzi0=;
        b=raeAN60/GYbB3RcRGKfCuSVu86x8PeAIZtrH8OctvGQYJRrkrwctzT8hJfo5kT8Qqi
         fCO/c7nP+VuWo+eumXpOiNeMao89r1xK7cMDm//580SipJ9crk2uuLun7oW7JGiKc3vS
         hXcwX18noupbLZ/GUdsq9xoZl30SDDUmq/TQvQ1ZHHc5GthrRWYaGUF9U5jl45e8q/EY
         /I+ZSb18afBPHvVKWZDFw7cg8+/+PQuBliTRbVj8dNBnYYkjmOl3qbIzlQoqZItzyEq0
         qsB2bO9L3wURVKYCtDgmb0pPeP8ItmnPd9gEtVHSStvhq9NSFJwrB+/YrxKuLKFMB0Ca
         PxSg==
X-Forwarded-Encrypted: i=1; AJvYcCWtXVIi0nDqp+GD5HKwPzlAsuvs142LxtQHKFgZmTEcka9pD9w2IubfRQ+6d2/Qy0fgTAHHORPaD0nb@vger.kernel.org
X-Gm-Message-State: AOJu0YxPa/6HhTL+Zi+DWoz8PogVmQOInWkXNWCK1aZi185YlQTnJ08Y
	wPjsH8aNlTmVMAONEWb2+is/WC/dEeu/7MLzHj9OzcABynKUse/cjge1dQYf76FHAzNSmC1kvJV
	1fxWpQg==
X-Google-Smtp-Source: AGHT+IF5B68oQa3k7/UGpi/UqtyKQBydmixDWz8HacctK8qNeiYGsnH51u5xIv/Vsp1Wc8UqEzEZfg==
X-Received: by 2002:a05:6402:5ce:b0:5c0:ba23:a55e with SMTP id 4fb4d7f45d1cf-5c21eda0c36mr12841715a12.38.1725310994022;
        Mon, 02 Sep 2024 14:03:14 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c243631d36sm3609838a12.72.2024.09.02.14.03.13
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 14:03:13 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86b64ebd8aso281368266b.1
        for <linux-s390@vger.kernel.org>; Mon, 02 Sep 2024 14:03:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWU6nQsbE5/9x1XskruJgiOkQaTsyYHVATos0e6BHR/2mZaTINJBGwBZj56I+PllqbNMfxfLD5G5sDD@vger.kernel.org
X-Received: by 2002:a05:6402:34d6:b0:5c2:5d34:a45a with SMTP id
 4fb4d7f45d1cf-5c25d34a63fmr2793579a12.2.1725310993097; Mon, 02 Sep 2024
 14:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <yt9dy149vprr.fsf@linux.ibm.com> <20240902134953.e834bc2e57d36b1d3b1397e4@linux-foundation.org>
In-Reply-To: <20240902134953.e834bc2e57d36b1d3b1397e4@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Sep 2024 14:02:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
Message-ID: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sven Schnelle <svens@linux.ibm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-s390@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 13:49, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> uprobe_clear_state() is a pretty simple low-level thing.  Side-effects
> seem unlikely?

I think uprobe_clear_state() should be removed from fork.c entirely,
made 'static', and then we'd have

        area->xol_mapping.close = uprobe_clear_state;

in __create_xol_area() instead (ok, the arguments change, instead of
looking up "mm->uprobes_state.xol_area", it would get it as the vma
argument)

That's how it should always have been, except we didn't have a close() function.

Hmm?

            Linus
