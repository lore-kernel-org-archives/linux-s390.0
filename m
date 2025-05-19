Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6A26988C
	for <linux-s390@vger.kernel.org>; Mon, 19 May 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642433; cv=none; b=HGC00aFkSn0+ITVfk1zAPNqqNKTW18VjJa2DhiwxfeVmhetBxJvH3Y0JoUfPy0lxHQigb+JGUuUvVvZJklGN4grJd00oMd9YBd7ANjCQlhHRsyoaAlenS+E25sTKDEYu0ayGbM/DEzEkPkJtEbxdBY+RL1jRcU3+ZXAX46AloXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642433; c=relaxed/simple;
	bh=Eu3W+hohQyyMEX725mTcqUwWoPBTenrR9qpK8mDWlr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plw7BNztGrkScTqA+VZwvB/lyqigwTno7EYr35DrxEovGFcAXc2eDpga2XvQLR0exvJ2rrWqhMdW4KbJ9SzJhOFqy/Ntlp8/eZWZnnSAxI2dA3Kfs/vlD5nrMYi/UxJSh8aNecMvmvQIY/IqRXu8LsDPb8mnHTQHlkJJWvr2qJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b19xKsP1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b19xKsP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747642429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=81MSjO1sHE2YfuqWDok69M/T/8z7rZ6g9u0DZWkIwK4=;
	b=b19xKsP1PAEX75FCU5+0/27LzLwxWysG3Y1SnoeyXEQRNv5aiXsE0Zi3ZqoLdhYT804BEO
	Me2X4oauKUBT4rkqUpyMHwf8xGPstoAHlAO6E5UxNkje1988Bfyr9A0ecM/RSNWlS3PsnI
	Xm2JoXXHOLFE40QZkH/xk680zYz2C+s=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-O1fcRoiLOVS1dJafSSpZmg-1; Mon, 19 May 2025 04:13:48 -0400
X-MC-Unique: O1fcRoiLOVS1dJafSSpZmg-1
X-Mimecast-MFC-AGG-ID: O1fcRoiLOVS1dJafSSpZmg_1747642427
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7401179b06fso3261899b3a.1
        for <linux-s390@vger.kernel.org>; Mon, 19 May 2025 01:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747642427; x=1748247227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81MSjO1sHE2YfuqWDok69M/T/8z7rZ6g9u0DZWkIwK4=;
        b=W8NCPQf9pN5PtoNn9s6eayyOg7NshYS0s+MiUm3rwvrU7UwrpwvSkEAI9R9dpQArf2
         88qKLDqC1dLew3jxbz7/Wl2Z99NlSMI0KXb26Gdzlw3TuQGayti0Hpo4yHbHCE9789ga
         gynAgCMm0B5WYFvJHIvTvSD8OUB44tkD9y4c+6AfBgFte/TbVKbBoJBWNfk4BreJQePf
         NbnKMow617M0ATjdlik8hsxiDX+JQvjKtUR0RObSRVSJ4vWwDwcTHGzjWZIiJPTKvSns
         LzxFzCK3Td/La25opOu3YjAyN4+NCh+1ClJpXHbjZuaxSkKQnIMQN2QWXTF+P7yOaAEV
         mDEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFa4vzrqhnkKIjWRtMTA2ZLEs5KEWi2WOjHTt2H07GLG25ndDQPXAXlzNGeRPsqBYF9Tzg4uKCNnIJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kN1oJ1n5FOSqp7xzXHkvKI1dFxbWMwvd30GEHlY+AAOU2kGA
	lUe6XkNIfCmSj6jrrFII2QdpFI4LBaudMW4heQ4W/XIIspC8DbDyieo7BpWH5a1NxLzwTFZevl7
	gN6xCJ2M8uqxAuE8xvAzxJtHUZxrTAE2+1p2OkpH+j8Yf2M7UfoTNlds/jHaVJfU=
X-Gm-Gg: ASbGncvNOYAEp5ccCAj1Ym1wxWOeyF5Tn3HJABYV3l7LqOHD4YJz1dV3Ku7vn+c1PE0
	LjhC4mk/Icoi7y9RbMCDJiV9iMmZZu/I/98yIkhm2C4/729pHL0p7xKN7M1aEh2PIiiPmoAB3DN
	ItVuI6zaETm0p5fzSxuaGmXDonS4S4ESUe6rR7WqqiUq2O0w0qXtKqR5+tG8TFNcS5+gQ0XQm/B
	OamzW0gUhJl1/7cMFjq/bl93dkKldRY+Tk5UF41cv7DpvsV6qeeVHuPHhMnMlrmi1Ds4LM1YlAG
	e3xmrV7MkOSD76h4
X-Received: by 2002:a05:6a21:7e86:b0:218:bbb:c13d with SMTP id adf61e73a8af0-2180bbbc1b0mr13503013637.13.1747642427018;
        Mon, 19 May 2025 01:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKS9dBCdoBJSd2fsnxqZtqXXkuCdfx1TMqH+JdIVWuZzC6jtmWsd4CbKxNWoE3TDYRsqvBDg==
X-Received: by 2002:a05:6a21:7e86:b0:218:bbb:c13d with SMTP id adf61e73a8af0-2180bbbc1b0mr13502979637.13.1747642426697;
        Mon, 19 May 2025 01:13:46 -0700 (PDT)
Received: from [10.72.116.146] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970b9c7sm5585368b3a.48.2025.05.19.01.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 01:13:46 -0700 (PDT)
Message-ID: <e90c3221-4a31-4c53-afb9-c2fcf09ae358@redhat.com>
Date: Mon, 19 May 2025 16:13:35 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 11/16] scripts: Add KVMTOOL environment
 variable for kvmtool binary path
To: Alexandru Elisei <alexandru.elisei@arm.com>, andrew.jones@linux.dev,
 eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com,
 david@redhat.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, will@kernel.org, julien.thierry.kdev@gmail.com,
 maz@kernel.org, oliver.upton@linux.dev, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, joey.gouly@arm.com, andre.przywara@arm.com
References: <20250507151256.167769-1-alexandru.elisei@arm.com>
 <20250507151256.167769-12-alexandru.elisei@arm.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20250507151256.167769-12-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/25 11:12 PM, Alexandru Elisei wrote:
> kvmtool is often used for prototyping new features, and a developer might
> not want to install it system-wide. Add a KVMTOOL environment variable to
> make it easier for tests to use a binary not in $PATH.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

> ---
>   run_tests.sh          | 1 +
>   scripts/arch-run.bash | 3 ++-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/run_tests.sh b/run_tests.sh
> index dd9d27377905..150a06a91064 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -36,6 +36,7 @@ The following environment variables are used:
>       TIMEOUT         Timeout duration for the timeout(1) command
>       CHECK           Overwrites the 'check' unit test parameter (see
>                       docs/unittests.txt)
> +    KVMTOOL         Path to kvmtool binary for ARCH-run
>   EOF
>   }
>   
> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index 8cf67e4f3b51..d4fc7116abbe 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -372,7 +372,7 @@ search_kvmtool_binary ()
>   {
>   	local kvmtoolcmd kvmtool
>   
> -	for kvmtoolcmd in lkvm vm lkvm-static; do
> +	for kvmtoolcmd in ${KVMTOOL:-lkvm vm lkvm-static}; do
>   		if "$kvmtoolcmd" --help 2>/dev/null| grep -q 'The most commonly used'; then
>   			kvmtool="$kvmtoolcmd"
>   			break
> @@ -381,6 +381,7 @@ search_kvmtool_binary ()
>   
>   	if [ -z "$kvmtool" ]; then
>   		echo "A kvmtool binary was not found." >&2
> +		echo "You can set a custom location by using the KVMTOOL=<path> environment variable." >&2
>   		return 2
>   	fi
>   

-- 
Shaoqin

