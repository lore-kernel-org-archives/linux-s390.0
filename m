Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9417F4CB5B;
	Tue,  4 Feb 2025 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697621; cv=none; b=Grl6vKf7qEu9/L6tEwtau+1YAP7XEylmf/6A5qrTgfRjeGWqNCZDvb1Gjl4j22vZ3nlNhrF+eXHI00Bw4uQgIVbYIW1tXI2iInrpfAYQOj3Xd0X1V0eh8IFCltV3PgBtpz3+yN31S5XIUwBuAU0Q5xl0+i8r4i8QZrfz+FzJNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697621; c=relaxed/simple;
	bh=vFM/rCKrCR+x4KTYKQS9sAG5LX9csb19UtNpPUC6eQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCpnGBcDUmvr7EfjhcKoWo3l5o6/MSq9SPT/ydAYQH6s6qqStDQF2cSksmugJWVev+b70tuqDAL8KubZSpEJWIBUiNxdAoOGsZlYzqeINmWWbpEN00kQ2NW7wYWRMNpHyCPIEty6/cU0y9efyo6vkCzGrIHpnu1hZb3Gc0K7cLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss1kgxWW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss1kgxWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C546C4CEDF;
	Tue,  4 Feb 2025 19:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738697620;
	bh=vFM/rCKrCR+x4KTYKQS9sAG5LX9csb19UtNpPUC6eQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ss1kgxWWE5RXdE7ThScmMhVz9Yxz8IREysTv0wV2gYxN0BM7oThqn5MJvsOw1PE/b
	 oHkQLqsWiTTAczI5HeNg1deekbaIaYTxSbcIgHvm/aK79oHl/CJHam6J5SE1C8PRl6
	 BqX0Pq3TXpdLeaALrUZ4te9Vn9AEp8Z4b8RFB1731KZHN79CSsYpn6PZ/hN3gYV+61
	 JEW48W1bBgFGLWA2QKsJpmomfFpMf9ulyVLOYVB+bOVehbF5PmE4abq/Zwvu9UOreq
	 RphoVqolh3di0rbaMiXMsqDHnSm44sMm8ZAJ03MjfJZLR6+d1oAYSNYSG3Yi7I4wgb
	 QouNYJs1K3tYA==
Date: Tue, 4 Feb 2025 11:33:37 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	linux-s390@vger.kernel.org, james.clark@linaro.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH 2/2 v3] perf test: Change event in perf test 114 perf
 record test subtest test_leader_sampling
Message-ID: <Z6JrkYYOkGcuKQOh@google.com>
References: <20250131102756.4185235-1-tmricht@linux.ibm.com>
 <20250131102756.4185235-3-tmricht@linux.ibm.com>
 <Z6GMmxKvXd0-fd_-@google.com>
 <9b091546-8178-470b-8904-dc948fd9aa11@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b091546-8178-470b-8904-dc948fd9aa11@linux.intel.com>

Hello Kan,

On Tue, Feb 04, 2025 at 10:55:44AM -0500, Liang, Kan wrote:
> 
> 
> On 2025-02-03 10:42 p.m., Namhyung Kim wrote:
> > Add Kan and Dapeng to CC.
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> > On Fri, Jan 31, 2025 at 11:27:56AM +0100, Thomas Richter wrote:
> >> On s390 the event instructions can not be used for recording.
> >> This event is only supported by perf stat.
> >>
> >> Change the event from instructions to cycles in
> >> subtest test_leader_sampling.
> >>
> >> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> >> Suggested-by: James Clark <james.clark@linaro.org>
> >> Reviewed-by: James Clark <james.clark@linaro.org>
> >> ---
> >>  tools/perf/tests/shell/record.sh | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> >> index fe2d05bcbb1f..ba8d873d3ca7 100755
> >> --- a/tools/perf/tests/shell/record.sh
> >> +++ b/tools/perf/tests/shell/record.sh
> >> @@ -231,7 +231,7 @@ test_cgroup() {
> >>  
> >>  test_leader_sampling() {
> >>    echo "Basic leader sampling test"
> >> -  if ! perf record -o "${perfdata}" -e "{instructions,instructions}:Su" -- \
> >> +  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
> >>      perf test -w brstack 2> /dev/null
> 
> 
> As a non-precise test, using cycles instead should be fine. But we
> should never use it for precise test, e.g., with p. Because cycles is a
> non-precise event. It would not surprise me if there is a skid when
> reading two cycles events at the point when the event overflow occurs.

Sorry, I don't think I'm following.  Are you saying "{cycles:p,cycles:p}:S"
cannot guarantee that they will have the same period?

> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks for your review and the comment!
Namhyung

