Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B777493651;
	Fri, 21 Aug 2026 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342844; cv=none; b=oHXqvdqQj19MjuLW1dUD/h8EkOnuee3gjHkoyEp9sxY+tArhAGdYs5XqOZ3RNvGhb2DmMP3KrPL49POpfk64ZNQsuthi4n/kq35P7fqDWWElvTdizdMbfmlW1vubbu/QDdG+7xHSWHvmh03Ml459bt2O0Cod0qeIUfCX+ucX+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342844; c=relaxed/simple;
	bh=lFAOkCt3qR6pSTMV0KAlkolRVlNyK8PS9Or1y8J6VHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=svAaikkcVZNmLduqsNNQZBpZrWVwxovs0ZUJrdxKNV3LlDnvRShAkT3SDURaSyS9T2arjbEvR0RXc/NU9DaSNSvKHSN0Id6ktOE3B2MwMBw2SSuXfDzb2tF/vEKNo2GFcn5hQcTbLnPdNtnOH18BQzo/DcaWwMsC02jJb1/2kCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjK8YomM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjK8YomM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9EC1F000E9;
	Fri, 21 Aug 2026 20:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342842;
	bh=KLt6bgNq0ZTavbzjuGzCnjGD4LqYxbmv0tA95HMQrYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjK8YomM40BKNTqDG/1//H+BTLt/Zz0Og/2GAxq+/8eqOj3LlIE69HU0sQD3cXEjT
	 zAvp8nF/gVMK06GaKTbwgID7aH31vs3gcsH+b/JORNHuhpOPtFNim5GpOfWGfeWURT
	 7RvGfycUYKpYVFO4oCrNZ90JV5kTpf2X4Vrg4gISHxe85crn9O9hL0b2Ey9KK0Cfqw
	 hqSWHfVIrr/MEualQyF0F+TQtsESYHg/1uy9uB4Oqrwji1AxOJZMYEo5e5keky3Bko
	 FHjfgka/t3UDLL8cjr6RZJkYlZzdFlKvv1OvQ4N0MF7dnNUe6gvpFcaHb9rLCpIX0P
	 fnyd3lDY4dLog==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 11/24] unwind_user/eh_frame: Wire up unwind_user
 to eh_frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-trace-kernel@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-12-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-12-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:07:22 +0000
Message-Id: <20260821200722.8E9EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unadjusted instruction pointer passed to eh_frame_find() for ret=
urn addresses.
--

--- Patch [11]: [RFC PATCH v2 11/24] unwind_user/eh_frame: Wire up unwind_u=
ser to eh_frame ---
commit 242304f470b193c92dc61308cce6cc9e66841ecf
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Wire up unwind_user to eh_frame

This commit hooks up the eh_frame infrastructure to the unwind_user
interface. It enables the unwinder to use eh_frame data for user space
stack traces.

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 830c620fe453c..85fc82252af15 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
[ ... ]
> @@ -173,6 +174,16 @@ static int unwind_user_next_fp(struct unwind_user_st=
ate *state)
>  	return unwind_user_next_common(state, &fp_frame);
>  }
> =20
> +static int unwind_user_next_eh_frame(struct unwind_user_state *state)
> +{
> +	struct unwind_user_frame frame;
> +
> +	/* eh_frame expects the frame to be local storage */
> +	if (eh_frame_find(state->ip, &frame))

[Severity: Medium]
Does this need to adjust state->ip for return addresses?

Since state->ip points to the instruction after the call, if a function
call is the final instruction of a block or function, passing the
unadjusted ip to eh_frame_find() might cause it to match the next
function's FDE instead of the caller's.

Would it be better to pass an adjusted instruction pointer (like
state->topmost ? state->ip : state->ip - 1) to ensure the correct unwind
rules are retrieved during normal user space unwinding?

> +		return -ENOENT;
> +	return unwind_user_next_common(state, &frame);
> +}
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D11
