Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CDF1DF268
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747193407; cv=none; b=qstexng4y+MVMKxBx6I5ppEcrzCQ6se4a19jAeM7lG/hEj2GTznBqrfwCoVG3OieEVeukh5WUzVZ6QeFrzqC7OrBDJjDvZiDXG9IFKaOUwoqdGIR+a6b/rdcwqetLc8SJLjnMeVsKe7RnNvzomDu8N4tyPgDp42fzEMOOMMoKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747193407; c=relaxed/simple;
	bh=xe+r7aUNbKYL48IaCa6f/vynWducxTozNskiWKlpSl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3jZY1RR5v3aAMQIqhdf3qkbBvF8hFeN+YoJzeDAktHw0twFwYEbvUEE8+Uvm3xWZ2IaLUfi4GRA7WhNSTFnpKqr6i9vptwVlQhEziNFdIhzt+WEhF1/Pf7iV5exEX4oCT1n2GW5EqBdpDx2NxSb4SgzYK6jxeC2CEW+aAAm2Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLqh14AK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLqh14AK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747193403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPNj1R9ALDGy4ZhAvSAe9nUoPzbthadZcf4T/oJDS44=;
	b=BLqh14AK3i7yq/SIhFdIqLoMtEscnaCcni++vjELUvuo9ccaUuNG2PsuvRAzWtKck4lnwI
	R2978GwDIgjes9m5so8sPcCpaEpVDmYdNs7Q867VAmHwlgvCVjTK1SR+cDKBQzJmIhvOTu
	iTk9sAxY4VXFDq+i+orSXwd7SHR2Y5Q=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-FzRdU36tM3WujF0R-vLY3g-1; Tue, 13 May 2025 23:30:02 -0400
X-MC-Unique: FzRdU36tM3WujF0R-vLY3g-1
X-Mimecast-MFC-AGG-ID: FzRdU36tM3WujF0R-vLY3g_1747193401
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7391d68617cso425122b3a.0
        for <linux-s390@vger.kernel.org>; Tue, 13 May 2025 20:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747193401; x=1747798201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPNj1R9ALDGy4ZhAvSAe9nUoPzbthadZcf4T/oJDS44=;
        b=SxuP6RRC0+QHszMlkvBMODqjdZHRHbcJxmgrFX1eI2yzlzhYPLFw/dC/ERl6e8INxV
         1XEq98g7iRp9G5DGFpcJtDFIQchuYPLDiDQbdLwyCkK+wTifowqjD2cqMOQealkkP4rM
         JsAmSCq/dyR2Yx2yONucTJBOSh8Tz8N4ey30+wzth+0UKLgB19Y8Fph25D073czlz7g2
         XmpkwbXO+LkxV2Q8HFx0v28sBJTty6OWjtMHDi8UDPkUM93xsje7OWvy81OzeFMYWSkU
         KhULhfwlJdRTH230oRlHRRthrfLpbvXsE09Z2lFwtTCGIa8Uvg4IuTqkyLklcN+8tBKd
         /8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU/H5nrXIFMM7/1rP7MeL04+pb1HIMCv16i4N+LlnQhv8qgOz1gw/Ds2nDuasXAzoAifKvtAMjlJ9ph@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdu9OLu5UUOzF5Nn0NYg76bwL7f07iY3oKWMtR34aUN1EVM5LP
	Oaf1ZmTjbxj3dd9jyz6PObjlFfO+EkMSzxGeSv3PwdgeETLFImm7d5DfWYAUrbSduO1W3/OCAfB
	Ydv3HGT8hP0NzRwE8bRu0VrVQuGIbsBB9nMAceIHA2qTVMCRLknCEOOgmrSs=
X-Gm-Gg: ASbGncvNGT0sOqk6he5vSkfbNhhRzuGVws/nidb+77ulV38/vGM9CmlVbYcg0sKQA54
	wv76dLvkxA1XM0sd3vz+uYdenju9Zj3CmFPdzOOpXlLP2m0yGxsfrhOBJwqENLu0cV0xmZr+Vd/
	0oMQQxQTXzjnHs7ESnaXfvg61AD325E0rw4+0T6sN8AfKe423jYqfmGz3gPBRnBQRaGDGc0CDCU
	JbX8yjAaFZ6jSDtApbUAX5pK70ASuxcTQKuC4qLv3hOO8oDvAcBX/aQ9hAOQ0mF2A2NCKqlhVJS
	6W//hHBdQi0onj23
X-Received: by 2002:a05:6a00:849:b0:73e:2367:c914 with SMTP id d2e1a72fcca58-7428907dbbemr2608211b3a.7.1747193401132;
        Tue, 13 May 2025 20:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4NfRMilmo0WhS6bonXckoq6ayKF8QYGypn6TRZn6O1csy9tmwHCGt4njEOo+8VL50NM6NRQ==
X-Received: by 2002:a05:6a00:849:b0:73e:2367:c914 with SMTP id d2e1a72fcca58-7428907dbbemr2608173b3a.7.1747193400666;
        Tue, 13 May 2025 20:30:00 -0700 (PDT)
Received: from [10.72.116.125] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a8a3adsm8406109b3a.158.2025.05.13.20.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 20:30:00 -0700 (PDT)
Message-ID: <54b5bb37-5304-4e73-afc8-bf2a23e6490b@redhat.com>
Date: Wed, 14 May 2025 11:29:51 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 04/16] run_tests.sh: Document
 --probe-maxsmp argument
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
 <20250507151256.167769-5-alexandru.elisei@arm.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20250507151256.167769-5-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/25 11:12 PM, Alexandru Elisei wrote:
> Commit 5dd20ec76ea63 ("runtime: Update MAX_SMP probe") added the
> --probe-maxmp argument, but the help message for run_tests.sh wasn't
> updated. Document --probe-maxsmp.
> 
> Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

> ---
>   run_tests.sh | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/run_tests.sh b/run_tests.sh
> index 152323ffc8a2..f30b6dbd131c 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -17,14 +17,15 @@ cat <<EOF
>   
>   Usage: $0 [-h] [-v] [-a] [-g group] [-j NUM-TASKS] [-t] [-l]
>   
> -    -h, --help      Output this help text
> -    -v, --verbose   Enables verbose mode
> -    -a, --all       Run all tests, including those flagged as 'nodefault'
> -                    and those guarded by errata.
> -    -g, --group     Only execute tests in the given group
> -    -j, --parallel  Execute tests in parallel
> -    -t, --tap13     Output test results in TAP format
> -    -l, --list      Only output all tests list
> +    -h, --help          Output this help text
> +    -v, --verbose       Enables verbose mode
> +    -a, --all           Run all tests, including those flagged as 'nodefault'
> +                        and those guarded by errata.
> +    -g, --group         Only execute tests in the given group
> +    -j, --parallel      Execute tests in parallel
> +    -t, --tap13         Output test results in TAP format
> +    -l, --list          Only output all tests list
> +        --probe-maxsmp  Update the maximum number of VCPUs supported by host
>   
>   Set the environment variable QEMU=/path/to/qemu-system-ARCH to
>   specify the appropriate qemu binary for ARCH-run.

-- 
Shaoqin

