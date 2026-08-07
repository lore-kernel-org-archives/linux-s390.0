Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382DC4746D7
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106295; cv=none; b=JUAriqkLeyWrPy7+lhWXaBSj+Qt7oXQT9JXC//998z/MdiQfhp2iIiEKr0FnGNmGQUazlY0E+EvjRkSAXSkH63VserFzxMAOfxPk/d8RIw+dLztX/O+2hUKUhmmW8rOD2q68abrpvL4Tjh9sjhJCKfAOYrq69wnmcShlplEZ8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106295; c=relaxed/simple;
	bh=rQEUnIeQrcdKhllBKnYZr8hjkVOXaqbZQ12o0LPmyJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s4yi2DLyUh2YHcK7fZ68JgPtMF4AX2Pc2o80KhtnS6SI5ygd93VN6W1c2W39aDk6HB0hkWgNwJCQSSppr2NfkiN1merJJobU1gI0jKAwVnU2ZiIjeAdN/AsuPdsnCE5ihPCnYkAC0I96ssTMEuNe9BOZ0C+rhyCT3DrErgfeweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9mEvarb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9mEvarb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8171F000E9;
	Fri,  7 Aug 2026 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786106284;
	bh=sU9QWbi0Qpg+KubnRbd0YFgmRByUznwxI0NXb1UctuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9mEvarbyhlnnpXw68lf4H/jlNiEF+j8irCIIyXbacvEHqszvtJcTkVyTwmdFL6F3
	 eT7qYe8cPhLqvRz9Pk6QnUaYgfZl/RWKskz0gD9CkjnlwEHibV7d7VbmKoOpnABVLP
	 OeaxpZAMiNyZyd5b+ct3fk/DX6SgkEesHGljt0luGv9WG7OEP9RYDdqYOB14qfoNZ5
	 jSxjj1g7PizvpcF7rdKD+wNfq8tPWFYBpGDLjFU1T638ApFyQqVTtWFAH42Ena2wQu
	 DRTGNKd9AFgDyXxu7k9i3gaT6ceUG2JVpd/F5xTE9ZFmHvxcfiKdkEelfU6uJ+1ZM3
	 l0LqkfNNeI0ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/cpacf: Unpoison instruction results
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807122132.3592583-1-iii@linux.ibm.com>
References: <20260807122132.3592583-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 12:38:03 +0000
Message-Id: <20260807123804.6A8171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `__cpacf_qai` unpoisons the entire 256-byte `cpacf_qai_t` struct=
ure, which could mask kernel stack leaks if a specific instruction's QAI ou=
tput is smaller than 256 bytes.
--

--- Patch [1]: [PATCH v2] s390/cpacf: Unpoison instruction results ---
commit 587dbefd826fa4c40d5401b72be74dfb37147586
Author: Ilya Leoshkevich <iii@linux.ibm.com>

s390/cpacf: Unpoison instruction results

This commit explicitly unpoisons CPACF instruction outputs to stop KMSAN fr=
om
reporting them as uninitialized. It leaves variable-length parameter blocks
for the callers to handle.

Link: https://lore.kernel.org/linux-s390/20260806190223.3292580-1-iii@linux=
.ibm.com/

> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
> index a83683169d98d..13d6a6344802a 100644
> --- a/arch/s390/include/asm/cpacf.h
> +++ b/arch/s390/include/asm/cpacf.h

[ ... ]

> @@ -370,6 +371,7 @@ static __always_inline int cpacf_query_func(unsigned =
int opcode,
>  static __always_inline void __cpacf_qai(unsigned int opcode, cpacf_qai_t=
 *qai)
>  {
>  	__cpacf_query_insn(opcode, qai, CPACF_FC_QUERY_AUTH_INFO);
> +	kmsan_unpoison_memory(qai, sizeof(*qai));

[Severity: Medium]
Will unconditionally unpoisoning the entire 256-byte cpacf_qai_t structure
potentially mask kernel stack leaks from KMSAN?

If a specific instruction's QAI output is smaller than 256 bytes, this
unpoison would hide the remaining uninitialized stack bytes. In
arch/s390/kernel/cpacf.c, the uninitialized stack structure is copied
directly to userspace:

arch/s390/kernel/cpacf.c:name##_query_auth_info_raw_read() {
    ...
    cpacf_qai_t qai;
    ...
    if (!cpacf_qai(CPACF_##instruction, &qai))
        return -EOPNOTSUPP;
    return memory_read_from_buffer(buf, count, &offs, &qai,
                                   sizeof(qai));
}

Could this regression lead to uninitialized stack bytes leaking to userspace
via the sysfs attribute without KMSAN detecting it, if any current or future
hardware query instructions write less than the full struct size?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807122132.3592=
583-1-iii@linux.ibm.com?part=3D1
