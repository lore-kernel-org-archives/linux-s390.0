Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F821B918
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241161; cv=none; b=P+3q/yhurst+GZgEBdAjG2ihM5pqSIEZ76uL+kia/+7VRrKRD5v7nZTOqdpYkw0JALVWlt2BOveFWrYuyudxJVJl5aQEDU5UHQHY2IXD/YPIb6j7xnLaKyQDLmmY5V4S0NveHcwOJWutJ19JJSuRjgW0g2Agj6xAo+S4PuSg7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241161; c=relaxed/simple;
	bh=ukrjupH5egcWjPIrYEOXsnCeUeOpJ1/OzRvd7wSeBYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX+p2POlAI4jCkEemIVX6KQ9951++F6li+dc6O+cVYt6siUAmJuSVQEC0x2p2SnhIbgK4oU8N4uoVjwX/ZstmIAfHgKFvCRT6C46gdLw3mmGnPQlC0+nPhjgkzHeQgQULHbEu/SxMQCvKd8tnwctejuxVX7dekJXZhr5E0A+x7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsxM91CR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsxM91CR"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73712952e1cso134580b3a.1
        for <linux-s390@vger.kernel.org>; Wed, 09 Apr 2025 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744241158; x=1744845958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5T7Kq+JsezAl05ddJh0OEYqxPcCvamnm3AWczPZJNs=;
        b=jsxM91CRzc8iheC6kl+ee/Cd9odEmxmvsRMjceARdbGhyxz2t98nWKGrkDYDt7IEPs
         /ojWvrCaKcNHtTJLo80oc351DJIWQyCNCdTTS4vjpisYqsxBHwYjDxJYPlE6oj1SR/7N
         spfOgYW4LOSo4bEUT0TjS+mxJjsLMm7RFVX7mRlp7V9bdDu1eqxfLhRmzgqDyMpnx9sy
         hv3FWeBtKHxKzQNE/oIS94vJDTTr/aSGLqC4asVqdQ7J0zIyuOK1gRwRckxrVsRLQOVp
         QRZSvXDvm5VxMr+NqIilMhMpf2684JLYKBFtg4gdjfTauKN3B+XLafnyiwO7L4QkNuIA
         Ch6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744241158; x=1744845958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5T7Kq+JsezAl05ddJh0OEYqxPcCvamnm3AWczPZJNs=;
        b=Gj/mMzAtesIGo5iPVfGW7U1GtxIpjVlxB/iQmfRQ68uaHwDeIRkO3GHmI9ert+kCiT
         wq9ihCkDtdApMBg0kXWq7ZJhcrTtKx/yxBoHbua84X+t4/cUTVGUtkFjtr3GFNH03tQV
         7/7LRMhYr7/lHsDY8sY/SabnBYqFpXwqbTff4SBPZTfN3pJGv6FMw1x4CjODYhb0AcE3
         2QLOaXF1Tr6DepOMGEpJIwAE7av6XJWRgVhaOse7+/qdPsb9n+WNsw58Wjr6r8UozihM
         v6b3MugLeVURa9fo4Au6EfBwd4BEny7vLPK0TekERwfVCPZFFvDORYi8b02Vz729HUoU
         l7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe8QmgTAsNH1YE/9eoDDMfjsygp1zSFRMXCNgRJVGL7ZpzWAKez7eR6w1WYc95yOFoEYl0OgcnIOFF@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1w0KFcY0G6LRxlMZx8EGWR6ldBv5LbdqT8gXmXyEF1lksLGg
	6xx2xZXEJqrp8XwNnl55Ni14QuLfIVgSHTIsS/ZJuJENqUkVMVm1KQ5W3cWkLA==
X-Gm-Gg: ASbGncuqShFALt4dOuxM5Fi9aHgIUQSPwYeIh+3dQZOFHZCIcw6EiWZO+zYbZA7P1vg
	pMQL4E197IN7zEEC1utgl52edSXMYPMYtUnwfWUaDNhvvdxtKnqcEYefA4Aj5mztJR80R7U83BB
	2GSAUAjYjQPxxEOwrhoQnBMRUgeJ4pQvc+iaYjCFEdymN0mOdyfnqpbBlyKfVv0NjjJ/y1wKMU7
	mDXJ1s3Upbf4tYIKj2ovhZITBcwg21GP9iwyXb5aUbEcpT0WbxWF8OXl1pnAG3JLx1QOHFUWHim
	zL/XkoZIKMfnhNJDSr0ihHadBeyHayIDvY0=
X-Google-Smtp-Source: AGHT+IEMzFEpbKhzggyTFKKB85VjCgHWSEXWQpQeollmLsyxwUqUjZkxvTzRUd/ogQVz1sI3xUGNkA==
X-Received: by 2002:a05:6a21:3394:b0:1f5:8e94:2e81 with SMTP id adf61e73a8af0-20169450f3emr1291592637.9.1744241158222;
        Wed, 09 Apr 2025 16:25:58 -0700 (PDT)
Received: from google.com ([2620:15c:2c5:11:b49d:1682:e317:e4f5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a11d2f78sm1810783a12.44.2025.04.09.16.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 16:25:57 -0700 (PDT)
Date: Wed, 9 Apr 2025 16:25:52 -0700
From: Chun-Tse Shao <ctshao@google.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v2] perf test: Allow tolerance for leader sampling test
Message-ID: <Z_cCACiCzF-2-6GI@google.com>
References: <20250408074641.1471473-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408074641.1471473-1-tmricht@linux.ibm.com>

On Tue, Apr 08, 2025 at 09:46:41AM +0200, Thomas Richter wrote:
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
> ---
>  tools/perf/tests/shell/record.sh | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index ba8d873d3ca7..b17e8b0680e2 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -238,22 +238,36 @@ test_leader_sampling() {
>      err=1
>      return
>    fi
> +  perf script -i "${perfdata}" | grep brstack > $script_output
> +  # Check if the two instruction counts are equal in each record.
> +  # However, the throttling code doesn't consider event grouping. During throttling, only the
> +  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
> +  # let's set the tolerance rate to 80%.
> +  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
>    index=0
> -  perf script -i "${perfdata}" > $script_output
> +  valid_counts=0
> +  invalid_counts=0
> +  tolerance_rate=0.8
>    while IFS= read -r line
>    do
> -    # Check if the two instruction counts are equal in each record
>      cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
>      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>      then
> -      echo "Leader sampling [Failed inconsistent cycles count]"
> -      err=1
> -      return
> +      invalid_counts=$(($invalid_counts+1))
> +    else
> +      valid_counts=$(($valid_counts+1))
>      fi
>      index=$(($index+1))
>      prev_cycles=$cycles
>    done < $script_output
> -  echo "Basic leader sampling test [Success]"

Would you like to add an simple division by 0 check?

  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
  if (( $(bc <<< "$total_counts <= 0") ))
  then
    echo "Leader sampling [No sample generated]"
    err=1
    return
  fi

And then `$invalid_counts+$valid_counts` can be replaced by
$total_counts

Thanks,
CT

> +  isok=$(echo "scale=2; val=$invalid_counts/($invalid_counts+$valid_counts); if (val < (1-$tolerance_rate)) { 0 } else { 1 };" | bc -q)
> +  if [ $isok -eq 1 ]
> +  then
> +     echo "Leader sampling [Failed inconsistent cycles count]"
> +     err=1
> +  else
> +    echo "Basic leader sampling test [Success]"
> +  fi
>  }
>
>  test_topdown_leader_sampling() {
> --
> 2.49.0
>
