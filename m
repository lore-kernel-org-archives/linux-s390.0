Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D33FD960
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677391; cv=none; b=OCR6FYUXXX3sELRlSrI4S8G/yTnzKbS5OBRLWLq+O3j/PR0zFHdbW4A3lUCLpGCCOo8OUxid/M2BNsBlD09xFxpzyrbb0u8Ld/WoXEQIGIhA8TufdpJoxmLuxSzyqInXKG3UogFzUz779b0Gc/VyutguSBybChkM7mR3l7/KfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677391; c=relaxed/simple;
	bh=y7Yx92GnkN+WHD07YIMZOFrt5RTUzcykzhKiBjKZW2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uua8jy0lC005ygA7czcsQdUcTqZYRfdskFkG28oX6lwo4qmzBeRcnTT9n7UU9kZoKMZPuMQ4tsn5J+O+l+RQwCxo1gJE8bBJGJ64Hbj5rO9EIcaH1V5uyC6XkKcGF//PfYa/AKkV8ldeKWf0RYP6C6gJTgUAAkwppzfWefB0snI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMBdxTtf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMBdxTtf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF89E1F00A3A;
	Fri, 10 Jul 2026 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783677390;
	bh=SxwlYTG4ofBRLEx9F54kIe3mArVI39EVXzSgYODYViI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMBdxTtfo+s4MWc7KrsbyOfRe5wumSOdGxlnTelEr6P9FQGSHNYemE7KPg+KwejyY
	 F8hezrQ6SzZPxdE6uhSPfONurjMOTx9DvWnzUgXUFX9IWr1rSwh8ER/xB4mJXLAFyh
	 xVWQkDh1UW4onmiwTOyeM/XOlqpi/QYl5TP+nxM751j5NRDX8M/2RiPF1MTqA98B+H
	 xZD+ZKOBklV5Ssu16eB0f6wfmDxAfKok2INaMXg6wdHImljY8PF3+z5a55SbD6xehz
	 lsKL5z1t+jEajhCqy/gXo3D7H/4whsbIHLh5NHWsVKipMLcSsiaxd8MsPz3tcfgKQG
	 Wk8uCBYJjv/EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next 08/13] RDMA/cgroup: Scope rdma cgroup device
 visibility to the net namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: tj@kernel.org, mkoutny@suse.com, "Heiko Carstens" <hca@linux.ibm.com>, hannes@cmpxchg.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260709095532.855647-9-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-9-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:56:29 +0000
Message-Id: <20260710095629.BF89E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Scoping RDMA cgroup device visibility to the reader's network name=
space breaks host-level cgroup administration and monitoring.
- [Medium] Concurrent lockless read of `device->net` using `read_pnet()` wi=
thout `READ_ONCE()` leads to a data race.
--

--- Patch [8]: [PATCH rdma-next 08/13] RDMA/cgroup: Scope rdma cgroup devic=
e visibility to the net namespace ---
commit 18e4bddcfb08bd42bef710d6d1b72824d15fa2c9
Author: Jiri Pirko <jiri@resnulli.us>

RDMA/cgroup: Scope rdma cgroup device visibility to the net namespace

Track each rdma cgroup device's net namespace and sharing mode, then filter
name lookups and cgroupfs enumeration to devices visible from the caller's
namespace. Keep the cached sharing mode synchronized across registration,
netns moves, and runtime mode changes.

> diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
> index 5e82a03b3270a..c8b4e3de76305 100644
> --- a/kernel/cgroup/rdma.c
> +++ b/kernel/cgroup/rdma.c
[ ... ]
> @@ -464,6 +465,13 @@ void rdmacg_unregister_device(struct rdmacg_device *=
device)
>  }
>  EXPORT_SYMBOL(rdmacg_unregister_device);
> =20
> +/* netns_shared is toggled without rdmacg_mutex, hence READ_ONCE(). */
> +static bool rdmacg_device_visible(const struct rdmacg_device *device)
> +{
> +	return READ_ONCE(device->netns_shared) ||
> +	       net_eq(read_pnet(&device->net), current->nsproxy->net_ns);

[Severity: Medium]
Does this lockless read of device->net using read_pnet() cause a data race?

When another thread concurrently moves the RDMA device to a new network
namespace, it updates device->net:

drivers/infiniband/core/cgroup.c:ib_device_rdmacg_change_netns() {
	write_pnet(&device->cg_device.net, net);
}

While write_pnet() uses rcu_assign_pointer() to update the pointer concurre=
ntly,
read_pnet() here expands to a plain pointer access without READ_ONCE(). Sin=
ce
rdmacg_mutex is not held during the write, could this plain read race with =
the
assignment and cause undefined behavior?

[Severity: High]
Does tying RDMA cgroup device visibility to the reader's network namespace
break host-level cgroup administration and monitoring?

If a device is moved to a non-init network namespace (exclusive mode), host
administrators and orchestration tools (like systemd or Kubernetes running =
in
init_net) will completely lose visibility and control over its RDMA cgroup
resources. Attempting to write to rdma.max will result in -ENODEV, and read=
ing
rdma.current will show an empty list for these devices.

Since cgroup state must reflect the cgroup's configuration independent of t=
he
reading process's network namespace, does tying the UAPI to
current->nsproxy->net_ns violate VFS semantics where an open file descripto=
r's
behavior would dynamically change depending on which process calls write()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709095532.8556=
47-1-jiri@resnulli.us?part=3D8
