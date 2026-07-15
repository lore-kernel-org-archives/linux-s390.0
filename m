Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5ED47DF9B
	for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125848; cv=none; b=SoKhWWhIzfIS9pl1sTLeUyynejMRuKZdHSCpAnHZGgjFJy8XXVjuU3+ZPGlyFuEvQQX9vyuT48fVYcD47Nc1ueOz2aZCBwhyY8zonD10Av7dUKHaTX2br6XPHwUQAcciBtBu06LHrzzjDmf2paI9jqzy0DDO2icGwdykiwygeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125848; c=relaxed/simple;
	bh=td4OQkGKNTmqBkXT/DQw5GEafo4O46MZv+LqNivhQb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VMamURscUWwrXbG2NL97yNse+bh1bLfvXydmUFszVUwkxIPv5U/+9emAxtu9ZSKQkI3pgKT8aIrRQSYUWIPFnTmvZrgEbvoA7XIacPWqIAnmEygzkvW1+l+xhcieAGi9NPzAI56cfY5debM6CUH0ObBdadCHnHvJOjjYY5BuhAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULJM8pu5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULJM8pu5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020451F00A3D;
	Wed, 15 Jul 2026 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784125846;
	bh=JL2uBXh88Ug7KgtT1wLVnM+ET6Ftpru0eTHSw/DyCrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ULJM8pu5MdBu/trxNTPjAbu3W9JiyFSV7xXIP/441SatqV7pJ6cVPjU3VREHxnX3l
	 SkrvXEPRTbu4fIpIz0UJMArqdqMN7ipwHFMsfZv+9urigcPZNlL+VHycjv/qKV2XFB
	 U8xc3yB/33TaaSpn5whcDlMpsbHxNWNlw8bZCtS64KPwebfuI+PELU0Nea3Z0kln+v
	 Xx5yKtMGKPBREZ4Y+GGsLqVh3RdzYQYCbW7fLyQ5jEytAIaGbn72SrE7LiKggeh+uQ
	 4RRizWsvQdS6rueJJP9j4Ztlo6nqu7QP542aBqtN5VJYtObpZkjbqJ3KeHxrU0406r
	 eKVWHkcLP+vhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next v2 14/14] RDMA/selftests: Add rxe_netns_names
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, linux-s390@vger.kernel.org, tj@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260714142927.1298897-15-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
 <20260714142927.1298897-15-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:30:45 +0000
Message-Id: <20260715143046.020451F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Asynchronous RXE device deletion causes race conditions and test=
 failures.
- [Medium] Asynchronous network namespace deletion causes test teardown to =
permanently leak the exclusive netns mode.
--

--- Patch [14]: [PATCH rdma-next v2 14/14] RDMA/selftests: Add rxe_netns_na=
mes test ---
commit dcc30384e696a4047f319e3b7139b30b3ddc09f4
Author: Jiri Pirko <jiri@resnulli.us>

RDMA/selftests: Add rxe_netns_names test

Add a kselftest script that exercises per-netns RDMA device naming
with RXE. Cover duplicate names across namespaces, move conflict
handling, move-with-rename, and same-namespace rename requests.

> diff --git a/tools/testing/selftests/rdma/rxe_netns_names.sh b/tools/test=
ing/selftests/rdma/rxe_netns_names.sh
> new file mode 100755
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_netns_names.sh

[ ... ]

> +cleanup_devs()
> +{
> +	ip link del "$DUMMY_A" 2>/dev/null
> +	ip link del "$DUMMY_B" 2>/dev/null
> +}

[Severity: Medium]
Will this cause race conditions between test iterations?

The ip link del command returns as soon as the netdev reference is dropped,
but the rdma_rxe driver handles the NETDEV_UNREGISTER event by scheduling an
asynchronous unregistration of the RDMA device via
ib_unregister_device_queued().

Could the next test iteration fail with -EEXIST when attempting to create or
rename a device to the exact same name (like $RXE_SAME) if the asynchronous
device_del() from the previous test hasn't finished?

[ ... ]

> +cleanup()
> +{
> +	cleanup_devs
> +
> +	ip netns del "$NS1" 2>/dev/null
> +	ip netns del "$NS2" 2>/dev/null
> +
> +	if [ "$MODE_CHANGED" -eq 1 ]; then
> +		rdma system set netns "$OLD_MODE" 2>/dev/null
> +	fi

[Severity: Medium]
Does this cleanup sequence permanently leak the exclusive netns mode?

The ip netns del command initiates asynchronous teardown by queuing
net_cleanup_work. If rdma system set netns "$OLD_MODE" is executed
immediately afterwards while the namespaces are still in the process of bei=
ng
destroyed, the kernel might reject the mode change with -EBUSY.

Since the script redirects errors to /dev/null, it seems the system's RDMA
subsystem could permanently be left in exclusive mode instead of being
restored to its original shared mode.

> +
> +	for m in "${MODS[@]}"; do
> +		modprobe -r "$m" 2>/dev/null
> +	done
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714142927.1298=
897-1-jiri@resnulli.us?part=3D14
