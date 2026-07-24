Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D6220698
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859647; cv=none; b=D/sGpFAb57CDiMrILw6GBRA42k6m2F6BeiiDQbpT58Y/D4S4e7prrTTot1eFQMXJcwTpzDPV+XBLfAzqH6sGIoTPYZVW2nKZnDAPqkncpAeNqLuuV+XgcoGWeh2QE3h6KLu0fCJ0yYqmmjEUUdUq0UGOG8ILMGEMmdqJaEIAsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859647; c=relaxed/simple;
	bh=1IUJcotMr2fJa2X08AW/+zAYKtJvF4L5NtOf8VDJByY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S8jZW7ypfvBDXwR76MuvznGDwRqczaEF9xozoGqFnlyB9e/cJvEfyE0HliwDuDIfumN3rHg+CjpVZyVSfl8LZ0QtzaiYd3uGeBB+arc/vtz1EsQpkpb+e8KEABkVUnYLJWuI/rf+KJfHVBeK8TnpJ+ZJK0gRC1ajKtnZWe6Bpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHVG/noi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHVG/noi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31F11F000E9;
	Fri, 24 Jul 2026 02:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784859645;
	bh=GOuPmkKnshdTzQ9tC/WFp//cXm0b0Zc7gc17cKjVIyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XHVG/noiayxvCgixWUCT1eGmpnN8dWCZTtd7gqSOSqejY1IFDPMsWbv3PVhHkxPR2
	 CU93L/FRvULgBmvPI9NJ4afiKcISatmj3ZsEUUtjAdZ7oJrGG6iu0pGBGo/yg+YjPU
	 gs2WQkybrs8yGEy5th/rgjHVdrMOXOFDP6+ywddNK+rLtQYGd9ZgTbNTaqwfjfyL47
	 Lpo6Y7fRJSyQVRU2LW0+9P84YkZDkXlAiPYvuhanRkq/FogD12pO3/uF3fO3Z6e5R5
	 FgY1RTPEUFtm45116ZZHgd3NhFGjkf0RA285PjW0sHlwGFTJzRpFZ0zesCnGaIfe/K
	 hcLy+Sg24V+Zg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/3] error-injection: Introduce EI_ETYPE_FALSE
 for fail_function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Chen" <chensong_2000@126.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260724021229.47302-2-chensong_2000@126.com>
References: <20260724021229.47302-1-chensong_2000@126.com>
 <20260724021229.47302-2-chensong_2000@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 02:20:44 +0000
Message-Id: <20260724022044.F31F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new EI_ETYPE_FALSE error injection type is missing string ma=
pping in lib/error-inject.c and documentation updates, causing debugfs to r=
eport '(unknown)'.
--

--- Patch [1]: [RFC PATCH v2 1/3] error-injection: Introduce EI_ETYPE_FALSE=
 for fail_function ---
commit 5374b818d585ee0b9130e232537545cf0e64070a
Author: Song Chen <chensong_2000@126.com>

error-injection: Introduce EI_ETYPE_FALSE for fail_function

This commit introduces a new error injection type, EI_ETYPE_FALSE. It is
intended for functions that require false as a return value during error
injection, such as btrfs_data_csum_ok.

> diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/=
error-injection.h
> index b05253f68eaa5..6c399121ab7ab 100644
> --- a/include/asm-generic/error-injection.h
> +++ b/include/asm-generic/error-injection.h
> @@ -8,6 +8,7 @@ enum {
>  	EI_ETYPE_ERRNO,		/* Return -ERRNO if failure */
>  	EI_ETYPE_ERRNO_NULL,	/* Return -ERRNO or NULL if failure */
>  	EI_ETYPE_TRUE,		/* Return true if failure */
> +	EI_ETYPE_FALSE,		/* Return false if failure */

[Severity: Medium]
Does this commit miss updating error_type_string() in lib/error-inject.c to
handle the new type?

Currently, error_type_string() maps the other enum values to strings, but
without an update here it appears it will fall through to the default case:

lib/error-inject.c:error_type_string() {
	...
	case EI_ETYPE_TRUE:
		return "TRUE";
	default:
		return "(unknown)";
}

Won't this cause functions annotated with ALLOW_ERROR_INJECTION(..., FALSE)
to display as '(unknown)' in the /sys/kernel/debug/error_injection/list
debugfs file?

Also, should Documentation/fault-injection/fault-injection.rst be updated to
document EI_ETYPE_FALSE alongside EI_ETYPE_TRUE?

>  };
> =20
>  struct error_injection_entry {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724021229.4730=
2-1-chensong_2000@126.com?part=3D1
