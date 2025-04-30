Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B01AAA0D
	for <linux-s390@vger.kernel.org>; Wed, 30 Apr 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025335; cv=none; b=L238p3IdBAYj7FGg3tZBHN95hZdrrCBt77TUI8i8ofho8YE1Qucs4EcsDpI4DAjAcVTUFr2xiZsYV34pTTHy5nrmch2KuYtRS0oovNWF/4TXal0ikfTJnMcSo/8TBVvtiMEdKXDPPzg8m9b+ZPR4CwxdQME2wrqx2y1Q/GS9efE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025335; c=relaxed/simple;
	bh=yTzOvPVZicdtXxYAN3i0WpG3riaGBG0fc2rbiaYZ7Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ka8nuJn2lmT1EhHMaiuc7oSEcjuYcnN6baj4tI5IWfvGPqQUhWxwCqmL4hvfys/6X4kI4yWgLoiU901niakYyXnUPGBkb1zGscJlG9LZUr527clxvBKZO6nPlMmcsiSTRoQ4yxCZm8jmwa+Rs3IG2F7NuBzYP8j+sIsVMlKOV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mCwyBwln; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mCwyBwln"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d44cb27ef4so185405ab.1
        for <linux-s390@vger.kernel.org>; Wed, 30 Apr 2025 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746025333; x=1746630133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxLP2jvQJU6ArGA2+B3kENikuO4EAauVA/47UH8n29s=;
        b=mCwyBwln/HBYY8iU0m6W+w5qb3vbbiXi5xOa7wbHpvlBJ6G2Tf9V7a38G6WnXQDpWJ
         pWiIOOcmkjNtNArn94Q/JuEW83q3Bcn6xzQaqAV1gHJzBA3TETQvxjF/bW9FEvuodOKS
         K9HSSB9CPHhfuLnflJeHCy6V+ifD6yYJAjQfS4l9amXmOCYpjQz6ckmpSAuj4ylVHwQv
         mLUOqrjNFFa9iDkg70wmNYyPRgCFAm8lvhkHRmp6UzSr0ChRGBPHfJMeL6xmpKHzzcrB
         2vAOk1C6NuACUPBKN+Ofoqv/5f9cKIAmrA5RZBPvYD4jcJ9KvSI96v5kUNvfTjWtl+cr
         b9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746025333; x=1746630133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxLP2jvQJU6ArGA2+B3kENikuO4EAauVA/47UH8n29s=;
        b=mHAMy62cfKz/O8C7k0MjLft4z2A9UDecFy/gnLTqSX6NKSjCp8soTzJaZoAjrvhpmZ
         IISL0jCMMG7OuwXVu+bD5/I9Y5UCBQ4XLJpHn8QfvLcVmH0FHxyWb9gJVkL4Ap2s+66e
         EwxsBL3YUEGQAjwaAxjkFUter3tiCxLpkDflvXdW3V8zL0PzG+dLW6aexKsz1Hl31rMl
         jCDriD5migKYMMYBKTElBTG48kH3vQAPvCzKvOWdOl+0ac+NeFiaqroWJVc+x3FR1u6f
         AlahBh1fzrnHcpSBceJJpyBHJQTWgnyufgWhrUtbdcm+DcxOGJBAqZ+OejbQmq6JHbPN
         GGUw==
X-Forwarded-Encrypted: i=1; AJvYcCX3oXAEHPWQThSYlrRN4YzgVc+023D0XkEJFAqlSRvQH6mAHolDNdXW0puwV1iwwdDyOLdVmKFl2iZe@vger.kernel.org
X-Gm-Message-State: AOJu0YzJS5aMkLGq/EQIhP+iKxoTcMgvL6sw5JyI+OAHha2RhxKvc05T
	CCHnyr1iD8Up2tMqdVioIyYxvmUdwI6hZe8fzz9g5RsxCiXoFRWYGyM+8Kj7jfkWCXJvO89zeYn
	cfxG08N1r8tgPXi3XWmtpp6DWKyNDOdPW52jb
X-Gm-Gg: ASbGnctNRRgYrYFOeoHmg9jRYuFRy5umQnibLuSKno72dHD83Av8qNak6vYRMjs+/BW
	XGcsV1QaOlxLhRcCvwbNYReJvpArMmj7dSFwDOtkeJQ3ccEvWS5RhcR5VV0+U5RVWu+4TvR/Lhq
	gj/F9vjVeA7WDDg/xuJC/flAF54Vj+BbKF5TB4TQ4oPpn/+5zgI8Y=
X-Google-Smtp-Source: AGHT+IFkE/B5i/O5ffd0Y9+cfOmEolUnMeNWp7gfguWLFWzrthiz5YGUN8hzcMmp9FogiKa7pA1epCiBXvFTujwV/cM=
X-Received: by 2002:a05:6e02:2164:b0:3d5:e202:6f05 with SMTP id
 e9e14a558f8ab-3d967612248mr4125325ab.18.1746025332744; Wed, 30 Apr 2025
 08:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430140611.599078-1-tmricht@linux.ibm.com>
In-Reply-To: <20250430140611.599078-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Apr 2025 08:02:00 -0700
X-Gm-Features: ATxdqUEjvqkuTaPqQIOIutbCYOx106q2eTjEroJsyqDujQ6PC-OfenpiCGQkBb8
Message-ID: <CAP-5=fXKp6sX2jndJjS7a9ycHW8F2iFxHLEQhJp4PiOAuanyGQ@mail.gmail.com>
Subject: Re: [PATCH V4] perf test: Allow tolerance for leader sampling test
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, ctshao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 7:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> V4: Update to be applied onto linux-next
> V3: Added check for missing samples as suggested by Chun-Tse.
> V2: Changed bc invocation to return 0 on success and 1 on error.
>
> There is a known issue that the leader sampling is inconsistent, since
> throttle only affect leader, not the slave. The detail is in [1]. To
> maintain test coverage, this patch sets a tolerance rate of 80% to
> accommodate the throttled samples and prevent test failures due to
> throttling.
>
> [1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Suggested-by: Ian Rogers <irogers@google.com>
> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 33 ++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 05d91a663fda..587f62e34414 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -240,22 +240,43 @@ test_leader_sampling() {
>      err=3D1
>      return
>    fi
> +  perf script -i "${perfdata}" | grep brstack > $script_output
> +  # Check if the two instruction counts are equal in each record.
> +  # However, the throttling code doesn't consider event grouping. During=
 throttling, only the
> +  # leader is stopped, causing the slave's counts significantly higher. =
To temporarily solve this,
> +  # let's set the tolerance rate to 80%.
> +  # TODO: Revert the code for tolerance once the throttling mechanism is=
 fixed.
>    index=3D0
> -  perf script -i "${perfdata}" > "${script_output}"
> +  valid_counts=3D0
> +  invalid_counts=3D0
> +  tolerance_rate=3D0.8
>    while IFS=3D read -r line
>    do
> -    # Check if the two instruction counts are equal in each record
>      cycles=3D$(echo $line | awk '{for(i=3D1;i<=3DNF;i++) if($i=3D=3D"cyc=
les:") print $(i-1)}')
>      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x !=3D ${prev_cycles}x ]
>      then
> -      echo "Leader sampling [Failed inconsistent cycles count]"
> -      err=3D1
> -      return
> +      invalid_counts=3D$(($invalid_counts+1))
> +    else
> +      valid_counts=3D$(($valid_counts+1))
>      fi
>      index=3D$(($index+1))
>      prev_cycles=3D$cycles
>    done < "${script_output}"
> -  echo "Basic leader sampling test [Success]"
> +  total_counts=3D$(bc <<< "$invalid_counts+$valid_counts")
> +  if (( $(bc <<< "$total_counts <=3D 0") ))
> +  then
> +    echo "Leader sampling [No sample generated]"
> +    err=3D1
> +    return
> +  fi
> +  isok=3D$(bc <<< "scale=3D2; if (($invalid_counts/$total_counts) < (1-$=
tolerance_rate)) { 0 } else { 1 };")
> +  if [ $isok -eq 1 ]
> +  then
> +     echo "Leader sampling [Failed inconsistent cycles count]"
> +     err=3D1
> +  else
> +    echo "Basic leader sampling test [Success]"
> +  fi
>  }
>
>  test_topdown_leader_sampling() {
> --
> 2.45.2
>
