Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0B1EFFBB;
	Fri,  2 May 2025 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746213119; cv=none; b=ht3ZK3qEGXSaEtgbr+ZPgKp0fvTLJ8jxcyxYudAhWgy4enEt+B0X3VhJmuyjuhQXdRLDVcsOdhgRMdia6HOvy0q9nafmrlzWIYNlb46dlzj7RUlneixqwQCaGU30z/o1vdNUq1EZ9INuTxbn1Y9yXK14yNZGFbccR+UF1i5Fa8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746213119; c=relaxed/simple;
	bh=8SeIdJB60MOAqSI90MujJ4ezCLgLTfpKSnF/Q+0MsZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ899CkmSM5/r/fzk12XKrpTG2VduXPuVY+PesXOM3WXYxSprySuJJrJ+Z0qsJPVkiRpzFrWceeMEXuYZMOT4vwQ3l+yNsPMmCyF022USS4besojgFVhbR/hvSTghtcOoj8BKCXWOqEI7gs9J7TQ9vqeTLIevB5wy7OULphW9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dutoPjKF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dutoPjKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6F6C4CEE4;
	Fri,  2 May 2025 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746213118;
	bh=8SeIdJB60MOAqSI90MujJ4ezCLgLTfpKSnF/Q+0MsZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dutoPjKFZIdmb/r4zhhKTTOhrU+RgPNZhP54f/Sfyyoezjk6OQbw3Qz/NDygG7k8b
	 TeV39MEn7C1JVoPUnT+pR0pOyE1z3AkKm3J87Hk7HRDNmROdfQrHeqelp0PZm8e1VW
	 kXw4Bhsl2ogVlzQHHBvgZhqmfjkQtPmgKRju2sp2wAqE3Gsv0xKR/eJDRRaZkaPjJ9
	 ObwLZsUlRvHxyEDnzmzBSyHZA8kLd0joK0vmOAClgxn9HyZAXyCj8pudwc3VXeqwqI
	 nDzB2VyPpRQ7BtO3xabN/UTrOg3PV2ECMel0eCSdkp5EgkCQEThpa7zoeCjZm+fud6
	 YW0ndsl1aRb7w==
Date: Fri, 2 May 2025 16:11:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, irogers@google.com
Subject: Re: [PATCH V4] perf test: Allow tolerance for leader sampling test
Message-ID: <aBUY-zaI6BxRvWWS@x1>
References: <20250430140611.599078-1-tmricht@linux.ibm.com>
 <aBT0a5lGzUSLpWpX@x1>
 <CAJpZYjWW07J8J40ygx6-5q_rfKEoz2g0VYCC=Go3PM2pBKvDRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpZYjWW07J8J40ygx6-5q_rfKEoz2g0VYCC=Go3PM2pBKvDRw@mail.gmail.com>

On Fri, May 02, 2025 at 11:21:07AM -0700, Chun-Tse Shao wrote:
> Hi Arnaldo,
> 
> I submitted the patch v1 and Thomas helped me to modify and submit v2
> and v3 while I was OOO. In this case I am not sure which one should be
> the author, maybe just keep it as Thomas.

From the tags provided, I think it would be best to list you as the
author and Thomas a a Co-developer, like mentioned in:

Documentation/process/submitting-patches.rst

Co-developed-by: states that the patch was co-created by multiple developers;
it is used to give attribution to co-authors (in addition to the author
attributed by the From: tag) when several people work on a single patch.  Since
Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
followed by a Signed-off-by: of the associated co-author.  Standard sign-off
procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
chronological history of the patch insofar as possible, regardless of whether
the author is attributed via From: or Co-developed-by:.  Notably, the last
Signed-off-by: must always be that of the developer submitting the patch.

Note, the From: tag is optional when the From: author is also the person (and
email) listed in the From: line of the email header.

Example of a patch submitted by the From: author::

        <changelog>

        Co-developed-by: First Co-Author <first@coauthor.example.org>
        Signed-off-by: First Co-Author <first@coauthor.example.org>
        Co-developed-by: Second Co-Author <second@coauthor.example.org>
        Signed-off-by: Second Co-Author <second@coauthor.example.org>
        Signed-off-by: From Author <from@author.example.org>

Example of a patch submitted by a Co-developed-by: author::

        From: From Author <from@author.example.org>

        <changelog>

        Co-developed-by: Random Co-Author <random@coauthor.example.org>
        Signed-off-by: Random Co-Author <random@coauthor.example.org>
        Signed-off-by: From Author <from@author.example.org>
        Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
        Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
 
> Thanks,
> CT
> 
> On Fri, May 2, 2025 at 9:35 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Wed, Apr 30, 2025 at 04:06:11PM +0200, Thomas Richter wrote:
> > > V4: Update to be applied onto linux-next
> > > V3: Added check for missing samples as suggested by Chun-Tse.
> > > V2: Changed bc invocation to return 0 on success and 1 on error.
> > >
> > > There is a known issue that the leader sampling is inconsistent, since
> > > throttle only affect leader, not the slave. The detail is in [1]. To
> > > maintain test coverage, this patch sets a tolerance rate of 80% to
> > > accommodate the throttled samples and prevent test failures due to
> > > throttling.
> > >
> > > [1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com
> > >
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > Suggested-by: Ian Rogers <irogers@google.com>
> > > Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> >
> > But who is the author? As-is this patch states Thomas Richter as the
> > author, but since there is also a Suggested-by and Tested-by Thomas
> > Richter, it makes me believe the author is Chun-Tse Shao, is that the
> > case?
> >
> > - Arnaldo
> >
> > > Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > > ---
> > >  tools/perf/tests/shell/record.sh | 33 ++++++++++++++++++++++++++------
> > >  1 file changed, 27 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> > > index 05d91a663fda..587f62e34414 100755
> > > --- a/tools/perf/tests/shell/record.sh
> > > +++ b/tools/perf/tests/shell/record.sh
> > > @@ -240,22 +240,43 @@ test_leader_sampling() {
> > >      err=1
> > >      return
> > >    fi
> > > +  perf script -i "${perfdata}" | grep brstack > $script_output
> > > +  # Check if the two instruction counts are equal in each record.
> > > +  # However, the throttling code doesn't consider event grouping. During throttling, only the
> > > +  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
> > > +  # let's set the tolerance rate to 80%.
> > > +  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
> > >    index=0
> > > -  perf script -i "${perfdata}" > "${script_output}"
> > > +  valid_counts=0
> > > +  invalid_counts=0
> > > +  tolerance_rate=0.8
> > >    while IFS= read -r line
> > >    do
> > > -    # Check if the two instruction counts are equal in each record
> > >      cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
> > >      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
> > >      then
> > > -      echo "Leader sampling [Failed inconsistent cycles count]"
> > > -      err=1
> > > -      return
> > > +      invalid_counts=$(($invalid_counts+1))
> > > +    else
> > > +      valid_counts=$(($valid_counts+1))
> > >      fi
> > >      index=$(($index+1))
> > >      prev_cycles=$cycles
> > >    done < "${script_output}"
> > > -  echo "Basic leader sampling test [Success]"
> > > +  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
> > > +  if (( $(bc <<< "$total_counts <= 0") ))
> > > +  then
> > > +    echo "Leader sampling [No sample generated]"
> > > +    err=1
> > > +    return
> > > +  fi
> > > +  isok=$(bc <<< "scale=2; if (($invalid_counts/$total_counts) < (1-$tolerance_rate)) { 0 } else { 1 };")
> > > +  if [ $isok -eq 1 ]
> > > +  then
> > > +     echo "Leader sampling [Failed inconsistent cycles count]"
> > > +     err=1
> > > +  else
> > > +    echo "Basic leader sampling test [Success]"
> > > +  fi
> > >  }
> > >
> > >  test_topdown_leader_sampling() {
> > > --
> > > 2.45.2
