Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A18312807
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152276; cv=pass; b=CYEZ8TvExSCVq9fbwToHIFmEeAHv91a5+5vq7LlxjacrzNbAC7XzixRwmm1M3I3vuaxYASV3PyTILtkBPX55lAHq5OmDYZS8mfCbb3bUmSpUuCGDq091zC6CUjHAjYruyVxdAnvmFcWkUlUg2b7jIQZnsEwq5eQ2xFcm1CKRreI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152276; c=relaxed/simple;
	bh=m11RxMrybFbYq1aegOwyhpbXAUpIQLIK+I74ptbAttQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVazkOXTIn8gyXdoyXj4eBOLtPW8ROrSyl6EW4QIQJSIgQrtzsOwylGclD74wNgOMtCC/cczttstaz/VNEMcMiabNgNU3h6ElOGNpwaT9BPP14TAeIc/Y2L6ro+DzK7QuqMf4cptYRwt4MnRB7JV8w154TAdpUfb14d+cWUr1V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFC+8vU4; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFC+8vU4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso5935ad.0
        for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 11:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782152274; cv=none;
        d=google.com; s=arc-20260327;
        b=VW0m5tQ4fjUZqy0Ja0ZnnJRaZoXmPJBvkY/UZXQBZCENJTecllL3BprUnVK5OTZO1v
         aMO5pcgZCwUq4kQVomz0vHbBG73w3MC71aOQTmed53KCg3PkNZTCHX08/UN9v4iKP5/k
         +P0EZ+QzuC4aPrfe1BiFF219tsJPCddlTGtUayte6bsqR472G5kRnlPLy8ooVwYjSmBj
         eyC8JsxXBET6dOD8Xhu1iOanyY9nuFSCgykhrii3bwKBP0OhZkGP+l9FvKr2z9NJjz+A
         5A8Rb6k3hBdiqw09ULLBas4IzHjG4NYP7Rsht+w7i/m1nPpRSDFzJ2rnaRcJHMS8ZISg
         FzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xtFt0nsYRVxh9pjtBHg13JFYnpuDwE2MjabpRY6kgzQ=;
        fh=/K9/DGuSXcxp4vOsgz7nzPMnI34jbZy2gxBjw1WGITs=;
        b=EmY2MNCs/iwC6EPrlbc9GTxzneMQuRdFzrZ3vABLnDQNPodxXQr10AaAtjBehOJwp4
         mBi9PvSOA+u+MnBwvtuYEkDOfHCUO5Exkid7xO2c4PFtLF8GznlCVjQ/sTUVQWS3IClU
         Nn1a1p7+GWpW5sBOX4XHgE5UKURgzgNN/KAY+0b6DUCq0+dcs2M5MgQJA48cLOCAbzpG
         btXaU4PmEYCVAv5GY6M7wUAWtY8heMHdQBSCilHUk3v0getQbECRU592IHDMw5dLTxRg
         dvZLoUlDXeCJg7UiS54OUUsPbdETQ6n0R+WrxGtvTdngazk27Z8moBWkVLVHRyqAZAIA
         1U+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782152274; x=1782757074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xtFt0nsYRVxh9pjtBHg13JFYnpuDwE2MjabpRY6kgzQ=;
        b=rFC+8vU46fBJHk9Al1hIp1OoWQ0dZf0zu0KH5BcwuwahChM35DhaGEhl6eF33pCkoa
         wLhSrKmBj+QZxJE8yhj3xLIhDW9etj7v7ASkkCeR2l+QVJ5IEvvReyHKImAaL8AYP+Bs
         TMWtngENOkmoDJPnIMrh/sDwxV1ZObK2Z/7auwv2sKRYV3mw5FYVjrDoTzfB0tw2f3vz
         r2LgYHQ0Iw3dj0NYA9s30mk2YOuwlQwQl4I87wJWQi0g6IJ7rhIdUWGvble5FZrGU4Ds
         h529j+uXs92BB/Sa+Zx1CJ8K72B2K/pXZfdHwJwLOkcPwElJeliAmDwCkDBymB7+O7QZ
         c0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782152274; x=1782757074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtFt0nsYRVxh9pjtBHg13JFYnpuDwE2MjabpRY6kgzQ=;
        b=Qfv+bqsUeyqcmX8vH3Sm/Y0rM9M64ILU3eHcDtOxuqtVeI1hnGja6tKILs/JoZUFvD
         kjwQt1iQmkD8ZUoji/rxIanWIRndU72FTvhXk6TtBAVmCXtLphaC5OJpCD7mm3Op5QiK
         AfiSDwPfSL9cLiMYZTewlRE5H5D7wq2p6U/W1oeOsWsiSDtLl3CYckkWBWqkZMYRmcjF
         23nfwPfdCw9o2f2N1CyheqPYTkMFs7uE2bks30jMJC8YF5/7qxY5torqpVHf7Q+iPjUV
         X/1jDSp4M4MMm6l6zrVI1a/OheetVd/UkASW6cbnsUiYFkIAV0/PSwO0aTLo+lQj+bVK
         fzmw==
X-Forwarded-Encrypted: i=1; AHgh+RqliH6Rxv8fHbNTTW+7bkTnA/JOJaWo/OTFTfvEmERh4fhB1LgCR26/XwwSczwgxKBVogNz08FDBk4x@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFOfZzifM0oxWqRNxRDtMuIHKG1oW0R2ZOVmflo27NIAfpI4g
	7wzzMtsxhCsRXdxrf8FMerkWp9RnumktQPsUlZMCkIcW2wrvFd23PULiPSVLgBIlFs7JfPRLecW
	Po6mE0EFuaeu3jE7qJaSpgsKR/rJz145V62STkbtJ
X-Gm-Gg: AfdE7ck6hIYHG0+W9ua2OhcYFXFSipqSUSpVm5dzhwPVSCAYh7gqGpIJ7lUuvCG1qoF
	H5KkAp/wSMSrl82EhsShhyUwFtVvYv6cTMakvNnba6S1vsRL9XoBflBtfc9u33dZEsuFXZ/PdeO
	wuU8wd8PmZjPY1IQrvjxWIjQv2mI8WVVpz6p0fgZL+IaF/NsKk0ITYRcHSLLVVkrNtr6iC01wyf
	sZAgVzcfbMyRr+M2vLvEV2PVQnDpSyyQPLpjeKL9jN6WiaMMwcQaO9zSysB+suaJuk6TuE1Lg==
X-Received: by 2002:a17:902:e842:b0:2c1:ee6e:4e4e with SMTP id
 d9443c01a7336-2c7c55c4688mr220605ad.31.1782152273465; Mon, 22 Jun 2026
 11:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619093531.4038655-1-tmricht@linux.ibm.com> <20260619094233.CBA9B1F000E9@smtp.kernel.org>
In-Reply-To: <20260619094233.CBA9B1F000E9@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jun 2026 11:17:41 -0700
X-Gm-Features: AVVi8CffVrqrwBpGjIxgkJVAl6Ad7IfgqkmawX297zMXF4nP1v65i27NURFYVVM
Message-ID: <CAP-5=fUJbh=dXiadCJJ4d_prCxox1G0WW_WODwSHC4DvwWuQag@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf test: Skip failing 'perf test aslr' test case
To: sashiko-reviews@lists.linux.dev, Thomas Richter <tmricht@linux.ibm.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 2:42=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Unconditionally setting `err=3D2` when skipping `test_callchai=
n_aslr` masks prior test failures.
> - [Medium] Skipping the test incorrectly triggers the test failure cleanu=
p path, leaking the temporary directory in `/tmp/`.
> --
>
> commit d772895777a1677561d1802ac157c32ce73e1379
> Author: Thomas Richter <tmricht@linux.ibm.com>
>
> perf test: Skip failing 'perf test aslr' test case
>
> The test case 'perf test aslr' fails on s390. This commit fixes the failu=
re
> by skipping the subtest test_callchain_aslr and emitting a hint when the
> --call-graph dwarf option is selected.
>
> Fixes: 60bc9fbc0589 ("perf test: Add inject ASLR test")
>
> > diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/s=
hell/inject_aslr.sh
> > index c00461828ea79..7fdb43679dc84 100755
> > --- a/tools/perf/tests/shell/inject_aslr.sh
> > +++ b/tools/perf/tests/shell/inject_aslr.sh
> > @@ -135,8 +135,15 @@ test_callchain_aslr() {
> >      echo "Callchain ASLR test [Failed - no noploop samples in original=
 file]"
> >      err=3D1
> >    elif [ -z "$new_addr" ]; then
> > -    echo "Callchain ASLR test [Failed - could not find remapped addres=
s]"
> > -    err=3D1
> > +    if perf evlist -v -i "${data}" | grep -q 'sample_type:.*STACK_USER=
'; then
> > +      echo "Dropping stack user sample as possible ASLR leak"
> > +      echo "Call-graph dwarf not supported with 'perf inject --aslr'"
> > +      echo "Callchain ASLR test [Skip]"
> > +      err=3D2
>
> [Severity: Medium]
> Does unconditionally setting err=3D2 here mask prior test failures?
>
> If an earlier subtest fails, the global err variable is set to 1. When
> test_callchain_aslr() decides to skip and assigns err=3D2, it overwrites
> this previous failure state.
>
> Since the perf test framework treats an exit code of 2 as a SKIP, the tes=
t
> suite will report the entire script as skipped, completely hiding the
> actual failure from the prior subtest.
>
> [Severity: Medium]
> Will skipping this test inadvertently trigger the test failure cleanup pa=
th
> and leak the temporary directory?
>
> The cleanup() function in tools/perf/tests/shell/inject_aslr.sh explicitl=
y
> aborts deletion if the exit code or err is non-zero:
>
> cleanup() {
>   if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then


Thanks for the fix Thomas! I completely agree with what you've done,
but it exposed this latent issue that we should make the exit_code/err
comparison -eq 1 rather than -ne 0. Perhaps Arnaldo can fix this, or
we can address it as a follow-up.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>     echo "Test failed! Preserving temp directory: ${temp_dir}"
>     return
>   fi
>   ...
> }
>
> Because cleanup() was not updated to handle the new skip state, it
> mistakenly treats err=3D2 as a test failure. This unconditionally leaves
> behind the /tmp/perf-test-aslr.XXXXXX directory every time the test skips=
.
>
> > +    else
> > +      echo "Callchain ASLR test [Failed - could not find remapped addr=
ess]"
> > +      err=3D1
> > +    fi
> >    elif [ "$orig_addr" =3D "$new_addr" ]; then
> >      echo "Callchain ASLR test [Failed - addresses are not remapped]"
> >      err=3D1
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619093531.40=
38655-1-tmricht@linux.ibm.com?part=3D1
>
