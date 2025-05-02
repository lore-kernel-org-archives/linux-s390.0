Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9C188713
	for <linux-s390@vger.kernel.org>; Fri,  2 May 2025 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210083; cv=none; b=H1oy7fd9OXp7nPy+aFqNR1QXuR8Hb/V7bcSFt1KKZURdbPecL2tvxbA1gUvhkHfReX3qTD2fGsSn37vFJw2hz3GZn9LXwwURkiF1T1XSYGbWIVIthPgUUv+k9Now8mLx2Tq7HrTWUUthw442vKUe6tNT4U2bq48fKBZfJq60Xhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210083; c=relaxed/simple;
	bh=2WAMa5lmi4lEi4ASbBbqVXM5gRQJLj8uyHr1nQ6tpio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rf+3OI16kEWBKij0mxpxBG5ApMUgKzvh1pwk224iSah5wq6WhsR23z/sbfBenNimLvufowjmjdE7mKzRBMChLjkTQMVhzRNGzrAC+aW2kpif3BziGEkNrUxABBZfkZRA+tcXX+sN1wdiZx9EMGv8xuz7sD/HOJrtyHoG7saHocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ypbvoqXw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ypbvoqXw"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2c663a3daso435885166b.2
        for <linux-s390@vger.kernel.org>; Fri, 02 May 2025 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746210080; x=1746814880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkMbn9QXaGEw1P97vg6t7ERPvjjVBU2OczUa5ek4HA4=;
        b=ypbvoqXwliPdsMPHAqRpYuOsGSXps19dsakqwFtVJV5HCu7/AP9HQMQgJJkMPiE6qU
         06Fc6dlPMR6F10mezDVMOiDE4cFbmmtRLnyBWB0J5yBHULIRuLw+HWZegNh2gOiReS+U
         4ohl6ln5TDaWBoQh7itolAPHn14w9/Jm6mTzU07ZjMjE/H5XcuQmFpjRenzgay1ChXNv
         Z58F54GyJXJ4xh/2mZJ/UV3Kg1NLS+Nqdr7DqTcqK7Vkn2T8EanQNBkQDJU1tzRSwu5w
         FqprMRc+3jyWcwvAaquVqZxFGzNcRPdyiu/94d0VNFOwNifVq3sMDeK3xzs/itdbikEv
         IP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746210080; x=1746814880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkMbn9QXaGEw1P97vg6t7ERPvjjVBU2OczUa5ek4HA4=;
        b=ga8pKb2/YDxV6vzL6I0jr4X8a2U/JZbg0cZn37aTwjkHnWIievodvhLSbGvN6ZYYWi
         8NeejUf9nDwp04W0Y3i9NGjhHLvJVb1XzC6W9/DNJpWMPr513ohjWgPLhzDYRbzBFr83
         LW/YBke4m8izGuGR8RRe6Tvmu+YX4GOKFLsNxRUJo/8t+EoWCpZD5EUdppqnWDKwwlIo
         zGbLSDGwrsrPA9WIa6Egs5fM+kPIMdJu/X/OxWzCO3zWfHmEYqScAOGWxMQWxRos6rWr
         iFL8cO5z3vEwB27o7Nhgso6ybqcKS8t9TmZDEKKAIufDP4Ho4NXBuqbpH8wDNbOjL3/X
         /S4A==
X-Forwarded-Encrypted: i=1; AJvYcCU8Cx0AwIV9FQd8jLWGqroFAG8tAKxAtmzvdg6MVyuY03vV5ZqJYZ3eXT2ixgt0qPQ3XODg4xHVOuRM@vger.kernel.org
X-Gm-Message-State: AOJu0YzpjbJIADIB04vaRlkXHluD2Aa0pxR+dVtGhLTZci+fq5vD/xoL
	wK+CmdIu8LcPva/iqCzO+PVtyz4JyLPEJqnERYb5WPrN57qURpf8xwtUVi5nvyKmBWtXxAPZfts
	eJiNUsQJuYcsXDQRj3EiGMy+bYC2wCFtibS+m
X-Gm-Gg: ASbGnctqyN3+gnoLLWXdHrYNSS4mk66eai7br7SpnIaryA4ot5O+O1PxQ317SAtw1jL
	60RquF2G5Yvf2H5KuqtFz2icY8rOTtV60k3WU7aReNBYzrx8sizhMdT2uKB+zyC2T/gV/r3LTCp
	h+QlpuUfXGkGZl8OXYJc2Z/b/kmacaFFsaN2o3gn4XS//LQ+yVsqXnyT8wyKnJeU6K/A==
X-Google-Smtp-Source: AGHT+IEdf5njijWY0ZrOWI1O0+1uGtYv2R15+pc7DLL6yq2G2gQkjnd/PdMfxhmqzzN2hFNRZe6U6KwT1CdUdShaq+E=
X-Received: by 2002:a17:907:c297:b0:aca:c9b5:31a8 with SMTP id
 a640c23a62f3a-ad17af654d2mr303967966b.45.1746210079771; Fri, 02 May 2025
 11:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430140611.599078-1-tmricht@linux.ibm.com> <aBT0a5lGzUSLpWpX@x1>
In-Reply-To: <aBT0a5lGzUSLpWpX@x1>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 2 May 2025 11:21:07 -0700
X-Gm-Features: ATxdqUHVxQdL0GCWAn6KorP0yATuhPIQ_Bazh2IodVceKAzOSd1WOrk1KyonOi4
Message-ID: <CAJpZYjWW07J8J40ygx6-5q_rfKEoz2g0VYCC=Go3PM2pBKvDRw@mail.gmail.com>
Subject: Re: [PATCH V4] perf test: Allow tolerance for leader sampling test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

I submitted the patch v1 and Thomas helped me to modify and submit v2
and v3 while I was OOO. In this case I am not sure which one should be
the author, maybe just keep it as Thomas.

Thanks,
CT

On Fri, May 2, 2025 at 9:35=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Wed, Apr 30, 2025 at 04:06:11PM +0200, Thomas Richter wrote:
> > V4: Update to be applied onto linux-next
> > V3: Added check for missing samples as suggested by Chun-Tse.
> > V2: Changed bc invocation to return 0 on success and 1 on error.
> >
> > There is a known issue that the leader sampling is inconsistent, since
> > throttle only affect leader, not the slave. The detail is in [1]. To
> > maintain test coverage, this patch sets a tolerance rate of 80% to
> > accommodate the throttled samples and prevent test failures due to
> > throttling.
> >
> > [1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
>
> But who is the author? As-is this patch states Thomas Richter as the
> author, but since there is also a Suggested-by and Tested-by Thomas
> Richter, it makes me believe the author is Chun-Tse Shao, is that the
> case?
>
> - Arnaldo
>
> > Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > ---
> >  tools/perf/tests/shell/record.sh | 33 ++++++++++++++++++++++++++------
> >  1 file changed, 27 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/=
record.sh
> > index 05d91a663fda..587f62e34414 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -240,22 +240,43 @@ test_leader_sampling() {
> >      err=3D1
> >      return
> >    fi
> > +  perf script -i "${perfdata}" | grep brstack > $script_output
> > +  # Check if the two instruction counts are equal in each record.
> > +  # However, the throttling code doesn't consider event grouping. Duri=
ng throttling, only the
> > +  # leader is stopped, causing the slave's counts significantly higher=
. To temporarily solve this,
> > +  # let's set the tolerance rate to 80%.
> > +  # TODO: Revert the code for tolerance once the throttling mechanism =
is fixed.
> >    index=3D0
> > -  perf script -i "${perfdata}" > "${script_output}"
> > +  valid_counts=3D0
> > +  invalid_counts=3D0
> > +  tolerance_rate=3D0.8
> >    while IFS=3D read -r line
> >    do
> > -    # Check if the two instruction counts are equal in each record
> >      cycles=3D$(echo $line | awk '{for(i=3D1;i<=3DNF;i++) if($i=3D=3D"c=
ycles:") print $(i-1)}')
> >      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x !=3D ${prev_cycles}x ]
> >      then
> > -      echo "Leader sampling [Failed inconsistent cycles count]"
> > -      err=3D1
> > -      return
> > +      invalid_counts=3D$(($invalid_counts+1))
> > +    else
> > +      valid_counts=3D$(($valid_counts+1))
> >      fi
> >      index=3D$(($index+1))
> >      prev_cycles=3D$cycles
> >    done < "${script_output}"
> > -  echo "Basic leader sampling test [Success]"
> > +  total_counts=3D$(bc <<< "$invalid_counts+$valid_counts")
> > +  if (( $(bc <<< "$total_counts <=3D 0") ))
> > +  then
> > +    echo "Leader sampling [No sample generated]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  isok=3D$(bc <<< "scale=3D2; if (($invalid_counts/$total_counts) < (1=
-$tolerance_rate)) { 0 } else { 1 };")
> > +  if [ $isok -eq 1 ]
> > +  then
> > +     echo "Leader sampling [Failed inconsistent cycles count]"
> > +     err=3D1
> > +  else
> > +    echo "Basic leader sampling test [Success]"
> > +  fi
> >  }
> >
> >  test_topdown_leader_sampling() {
> > --
> > 2.45.2
