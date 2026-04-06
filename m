Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317134D4CB
	for <linux-s390@vger.kernel.org>; Mon,  6 Apr 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491889; cv=pass; b=tYp+POd0DxOOxM0N6jTAzfKKCt1lbO6gxgsSIgY8fOlTFCcEPtPM4Yx1bSu7U481Sz9mFjN5RlNQNol3KYKMD+t2niRPTVRjSqXjFCW8gXugtOqxi0DeoXc4WKz1kR/iEMct9mOtA/G3nyPmtXnRwRAHdF3DZufT1+u1FuEjr+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491889; c=relaxed/simple;
	bh=6rXUBCUZbg9vIzk9rudSe/qcgXU5Be5B8LMI2la5dYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E36HwDPnhzH5aQIBeJYh9djwZZ/33QaEyHV34gYkiV+L/Llu77hMll1HID9g2VvhkAXvqF4wWvfBeUFRjEDW57YD8oUseempJ/fdKWrMUVuO6y7g2FXIxtuN+Blyf9RcBGDARuBG86S0Ce7s0jdWIJRffuEInl1MudkjUHl6XHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qc0dgBI3; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qc0dgBI3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0b260d309so213415ad.1
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2026 09:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775491888; cv=none;
        d=google.com; s=arc-20240605;
        b=UICSVAIcRKL9mUUqnyk63uDZrg7habHGPlolaLLdIjsXWFIBWKdT397dSfuvzpwJxc
         bEV+O6sZUG9IYVSMCszlFkfstOPCfZeP/X9elS3wUzEK6glY5paxY6psFeq+tYyBLUz/
         w5ud44ZQHqKXRIajgGCQpI1Ay/dhuQ2r7d2Y05sr43Kzkm48peg4e8DAtUaUjuotEXIS
         WFgwYPzlqkHJVdfaYtJI5EZutzPEgke86khbijXdQrVgY3SfaqdVDXt0kbZAasTqniOF
         rGvhju4fMp4vA2Dd6YNrxPFjUIREW2NE7ASDLVsu+gNmTMeeOqveuklx8IDZjkUcJsn4
         AmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1x81r3iRTa3fxKPMBJ/Qvf8xplCbNBHfOYy0Aqmmj78=;
        fh=/oD4AUFVX7QB+P+UQll9/rJOJAmbYchd0kl650fnqus=;
        b=S27DxUmc+mLcYO8liBEJ/AT6Y+Qh/i6u4KA4z99fvujNnsPhP2vbGDWx62FFqfhC7+
         oglBS3R2hcLJoNdwF9UCQiRdD9mXTI4nd3ldPOHDHUsdrvxZqoxoB2rQcTeO4BzSyH6d
         M8cGlJct/kGq9cSeFdkJIr4crEAWwkoI1sXxcqjPMFeArQrquK6rfrSApmaUTOA3Ye3p
         0jNBTBt0QE2y0aidWOD9FpK45IvXHma1xrbvDVC8zkm2Unlzo8qDqIJ0iNLalgPP2ZRk
         AMx0pTjDtbJvGVWP/a0ME+qCMeQIi2oLb1jWrZ0ybtOyu2zv2nvBe9nYPxEUIInpJ/1g
         AeRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775491888; x=1776096688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x81r3iRTa3fxKPMBJ/Qvf8xplCbNBHfOYy0Aqmmj78=;
        b=qc0dgBI376ijqE+KGptbl77EYwV4p/eeqDfbUc/oKx6naAKunRo/h9XmKA0rxrCjl6
         ScmRbrqiLkhMV9Mg2C8N0qelaL1bGbvtJLXnJns5ndCuUOiMJ+MIH6WQsqU4GMRhO48f
         SGHZ5ZqgicvzGqqKE6m4tQAaneUK2/A+vRw3UBsLDGExQAapYhXNccU/kYarQHhh6VDp
         BCfjmdcusq231aZsjRMdu1xBUHfv3tAZtkD44AqO+l0O29vHPCoukNBXnzt4SoKAsCP7
         z25tqJkgDFr+KstwkNTqAjsHRZFBtcHYTzBNRc5+bANFKIx48CQmtaDvPD+zUAQgOp3v
         N/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491888; x=1776096688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1x81r3iRTa3fxKPMBJ/Qvf8xplCbNBHfOYy0Aqmmj78=;
        b=YQ2V2WR4aPB6LXz4zhO5y1ZdrM7tjWlNH7ICG5/ov1ehwkfShY7doqajkLvFZg4J0t
         N812ToSQRhexL5+vvE1EWoV1Ib2INv5U8JP3tOOwyI1UhXMdUOv1Dtu9PIrUDmOG3gRO
         4DNNxWOFV2JWOn4rSc0l0wcS7FwHtvO2nhG1QTMU130mQm68LDiYPsJD21n3XKtMJQRs
         xLSfGk0Hx3YgmQJkAsNPvKuHpQsV49SJY6eXfjH/54fuP3378KQaZ+LKp3PdupI7swBM
         CNrIB+VaGafk34lu/Kh5PHXKYhz2xtpAQROvapVwTxxiJs7Qhsf1rwrwO0KnSivGEg0X
         C2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTrTd6nzczEryuehLMJfvadlfXAhjRgA8yImuiuwoyuJRx7fCuUj6PuuE7iL88Z6JATW96Y1gOYjbH@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLCgL9ENTu/fqzAaXJaA9i2/uzCMlLw2bdLYd1/ofGxHnAYKm
	4MNto9BTiz/9JU/eo7vWkBTm3D7wa3X+wQs67VWOfKWtFjxySWb4xfMl1wEdhGTSKFAz+UwNs1O
	1MYPbO/75OPNEaO2g51Q996hH6imDn7mwurblZ9H5
X-Gm-Gg: AeBDiesWmaHGtMtwL8QDFmSS6/UuH8gtQAacOXUs2kKnp/cLUyaCar5oJ0qPkT8Her2
	Pcc+IMkNXdRbMdzoWEUEpxDmz7YZkJyOx422cA4+wYU8Loh3+2G9C5Mw3ExlpC55ao8afCUMzhu
	z0crFSaNHgSorb7W31rm60FnfGiCQxDMFo2ui5cfj+MXppO5Uikmx70+MhmqMTz5bghQrz76YLw
	U3H8HmRhUUquVocFoYku6ANkfOSDEogvYtNMDwlVQKHJuwDfyI3FzxMWnv6YmUtO7qRBw5ClffR
	S5HbJMAYYqokU8l1RpdIjckvqYSxrKEYgUhj0g==
X-Received: by 2002:a17:903:22d1:b0:2ae:7fa2:6bda with SMTP id
 d9443c01a7336-2b283f049edmr7309275ad.1.1775491887460; Mon, 06 Apr 2026
 09:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326174521.1829203-1-irogers@google.com> <20260327045025.2276517-1-irogers@google.com>
 <20260327045025.2276517-3-irogers@google.com> <adNAQzNcCufAf6Jk@google.com>
In-Reply-To: <adNAQzNcCufAf6Jk@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Apr 2026 09:11:14 -0700
X-Gm-Features: AQROBzD6OZSk3B9NDHQDgnQVI83ou6Tcl6__NEgXrtGy9dCtraIUwzq2i7bBN4s
Message-ID: <CAP-5=fXxa2rvxMqZoD5ayETiPjS8cf7A49TdVwwt+10uPu58Pw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] perf symbol: Lazily compute idle and use the perf_env
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, tmricht@linux.ibm.com, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, jameshongleiwang@126.com, 
	japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 10:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Mar 26, 2026 at 09:50:25PM -0700, Ian Rogers wrote:
> > Move the idle boolean to a helper symbol__is_idle function. In the
> > function lazily compute whether a symbol is an idle function taking
> > into consideration the kernel version and architecture of the
> > machine. As symbols__insert no longer needs to know if a symbol is for
> > the kernel, remove the argument.
> >
> > This change is inspired by mailing list discussion, particularly from
> > Thomas Richter <tmricht@linux.ibm.com> and Heiko Carstens
> > <hca@linux.ibm.com>:
> > https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ibm.=
com/
> >
> > The change switches x86 matches to use strstarts which means
> > intel_idle_irq is matched as part of strstarts(name, "intel_idle"), a
> > change suggested by Honglei Wang <jameshongleiwang@126.com> in:
> > https://lore.kernel.org/lkml/20260323085255.98173-1-jameshongleiwang@12=
6.com/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> [SNIP]
> > +     if (e_machine =3D=3D EM_S390 && strstarts(name, "psw_idle")) {
> > +             int major =3D 0, minor =3D 0;
> > +             const char *release =3D env && env->os_release
> > +                     ? env->os_release : perf_version_string;
>
> I think Sashiko's review is right.  You need to check the kernel version
> instead of perf.

Doing this can create more problems and complexity than it solves. If
we state that `os_release` can be NULL at this point, we recompute it
using `uname`:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/header.c?h=3Dperf-tools-next#n378
then do we cache the value in env? What happens if a data/pipe file
that assigns to the env later? Ad-hoc users of env->os_release
recomputing it shouldn't happen; instead, in 'live' mode, we should
assign os_release using uname either when the perf_env is created or
lazily with a helper function. I dislike that with a helper we could
potentially have multiple notions of os_release.

I'll add a patch to refactor the use of os_release, but can we be
mindful that this is clear feature creep with little benefit? We will
still fall back on `perf_version_string` if uname fails and for all
practical purposes, `perf_version_string` will differ little from
uname in this case. I'm only going to add the patch because checking
other uses of os_release suggests the change is benign.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +
> > +             /* Before v6.10, s390 used psw_idle. */
> > +             if (sscanf(release, "%d.%d", &major, &minor) !=3D 2 ||
> > +                 major < 6 || (major =3D=3D 6 && minor < 10)) {
> > +                     sym->idle =3D SYMBOL_IDLE__IDLE;
> > +                     return true;
> > +             }
> > +     }
> > +
> > +     sym->idle =3D SYMBOL_IDLE__NOT_IDLE;
> > +     return false;
> >  }
