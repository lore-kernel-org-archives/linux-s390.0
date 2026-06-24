Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881422FDC27;
	Wed, 24 Jun 2026 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330174; cv=none; b=sFvoKUcqrRY7KeNGmGCeMm2RzYIh+ghnVQ3zwCtkh1y5rDDgASC3+UtEl1QLdlllPpqG3Kh7Oilhbmi/GfRC+X/Ei0RrurNHaMYf6xu5xVlojbxvJWjYDNPeszWTlxeuaVU+Tq7P0OAxT4piGHEUMnIWqGV/WhXaZ2tRuN0kyaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330174; c=relaxed/simple;
	bh=k51SzreYYc6OWMxarcx2xv3vo2OEIeu4VVhb4u47im8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJEBENXbgBy2+lcPNuuKGPaxLTz6/xM9rRADmuH7L9CkKyTAACcjeIQkLRk1+upVGzWXX/DEdyN3Z9x6i3vNa8d+QvMOUtZCdLJBeNGu2KoHvz72LXG5DA0On9L9GdB8TNKubTQ1XykkpI0x28L/B/Bas54AgpbLT8CsLE9Dh8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSNs8RiX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSNs8RiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33271F000E9;
	Wed, 24 Jun 2026 19:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782330173;
	bh=XaTrra4jAwM7L+mMY3rH7yoWBvnMPGJ0SOPpDlK5TFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aSNs8RiXUHbaqK9HgAP+PzqZnR13tvauD5sKlkH6LYuaNo+wcmgjCeR1uMob7J+dz
	 hEyNF6TPVWrLkO5N49Dq1bsw02bFuEC0mOY4LyNWNy4U8+O9nfheBzoMzL20RMftzR
	 XWGBL80Z5VrWMrvUgANMNo5ELCGjPhjy1pW76Vdp5sjk/0cjUlX3XAdc9PHkhkzZrI
	 IrlgNjal7f4kV+82hFDqFQQCaCIbjNHGYMENANZZgsmSilftKxRDpGPr5uGy/KmHYc
	 mGUPBaqr0KPr0jw8jLVCaOybTyNIvvlpdAwbtTZzANiGmlQvRuQVCUjkt4opDo0JLN
	 zgcX559s8JIZQ==
Date: Wed, 24 Jun 2026 12:42:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: sashiko-reviews@lists.linux.dev, Thomas Richter <tmricht@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH linux-next] perf test: Skip failing 'perf test aslr' test
 case
Message-ID: <ajwzO4GJ8Uj_2mwi@google.com>
References: <20260619093531.4038655-1-tmricht@linux.ibm.com>
 <20260619094233.CBA9B1F000E9@smtp.kernel.org>
 <CAP-5=fUJbh=dXiadCJJ4d_prCxox1G0WW_WODwSHC4DvwWuQag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUJbh=dXiadCJJ4d_prCxox1G0WW_WODwSHC4DvwWuQag@mail.gmail.com>

Hello,

On Mon, Jun 22, 2026 at 11:17:41AM -0700, Ian Rogers wrote:
> On Fri, Jun 19, 2026 at 2:42 AM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [Medium] Unconditionally setting `err=2` when skipping `test_callchain_aslr` masks prior test failures.
> > - [Medium] Skipping the test incorrectly triggers the test failure cleanup path, leaking the temporary directory in `/tmp/`.
> > --
> >
> > commit d772895777a1677561d1802ac157c32ce73e1379
> > Author: Thomas Richter <tmricht@linux.ibm.com>
> >
> > perf test: Skip failing 'perf test aslr' test case
> >
> > The test case 'perf test aslr' fails on s390. This commit fixes the failure
> > by skipping the subtest test_callchain_aslr and emitting a hint when the
> > --call-graph dwarf option is selected.
> >
> > Fixes: 60bc9fbc0589 ("perf test: Add inject ASLR test")

Shouldn't it be 190c45463844?

> >
> > > diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
> > > index c00461828ea79..7fdb43679dc84 100755
> > > --- a/tools/perf/tests/shell/inject_aslr.sh
> > > +++ b/tools/perf/tests/shell/inject_aslr.sh
> > > @@ -135,8 +135,15 @@ test_callchain_aslr() {
> > >      echo "Callchain ASLR test [Failed - no noploop samples in original file]"
> > >      err=1
> > >    elif [ -z "$new_addr" ]; then
> > > -    echo "Callchain ASLR test [Failed - could not find remapped address]"
> > > -    err=1
> > > +    if perf evlist -v -i "${data}" | grep -q 'sample_type:.*STACK_USER'; then
> > > +      echo "Dropping stack user sample as possible ASLR leak"
> > > +      echo "Call-graph dwarf not supported with 'perf inject --aslr'"
> > > +      echo "Callchain ASLR test [Skip]"
> > > +      err=2
> >
> > [Severity: Medium]
> > Does unconditionally setting err=2 here mask prior test failures?
> >
> > If an earlier subtest fails, the global err variable is set to 1. When
> > test_callchain_aslr() decides to skip and assigns err=2, it overwrites
> > this previous failure state.
> >
> > Since the perf test framework treats an exit code of 2 as a SKIP, the test
> > suite will report the entire script as skipped, completely hiding the
> > actual failure from the prior subtest.

Right, it should not overwrite if it's already 1.

Thanks,
Namhyng

> >
> > [Severity: Medium]
> > Will skipping this test inadvertently trigger the test failure cleanup path
> > and leak the temporary directory?
> >
> > The cleanup() function in tools/perf/tests/shell/inject_aslr.sh explicitly
> > aborts deletion if the exit code or err is non-zero:
> >
> > cleanup() {
> >   if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then
> 
> 
> Thanks for the fix Thomas! I completely agree with what you've done,
> but it exposed this latent issue that we should make the exit_code/err
> comparison -eq 1 rather than -ne 0. Perhaps Arnaldo can fix this, or
> we can address it as a follow-up.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
> >     echo "Test failed! Preserving temp directory: ${temp_dir}"
> >     return
> >   fi
> >   ...
> > }
> >
> > Because cleanup() was not updated to handle the new skip state, it
> > mistakenly treats err=2 as a test failure. This unconditionally leaves
> > behind the /tmp/perf-test-aslr.XXXXXX directory every time the test skips.
> >
> > > +    else
> > > +      echo "Callchain ASLR test [Failed - could not find remapped address]"
> > > +      err=1
> > > +    fi
> > >    elif [ "$orig_addr" = "$new_addr" ]; then
> > >      echo "Callchain ASLR test [Failed - addresses are not remapped]"
> > >      err=1
> >
> > --
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260619093531.4038655-1-tmricht@linux.ibm.com?part=1
> >
