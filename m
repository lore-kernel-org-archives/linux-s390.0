Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843EC345CBF;
	Thu,  6 Aug 2026 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032365; cv=none; b=FbemrjXniLd+UQGq9wrxO3INRRXJLPQf8A7yPdRwa1WiHaQXRqSC2skGo37ioceccUWoCg8YoeCgyj5GEO2y3H9VuKKyVhcb7KrfDfTZLvjb1Fesaai4Glds5tuYW9WQxOBU3XpSfGKepl7w0VOs0NvuthKnL7j7sHgToTFH15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032365; c=relaxed/simple;
	bh=OXBwJaRMCb2aSFuWE6aiT3EAFjw/9ijMnx44w28eW5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ec9DExtt+hpjVs3wXYSoBFTflvvXmbG3X2NkVMX/ecSbLfyiybRv/H+hNxQ+8pIcvuJ1QrlPD3AZghjpmROkreKN7YBCuhJnWeUZXzbiJ8BsMWfhKm7JhPsZekUxqZ4U2vVaAGRfNiMmfA3nw2Dhd0KqjdWain8wBoyyzwxxJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq529Eog; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq529Eog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFFB1F000E9;
	Thu,  6 Aug 2026 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032364;
	bh=4g5lIJuAXeCvLIdENMvuGJsh3TqPAvXxzk9fJ6oXTCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nq529Eogeb7j9p6duSCkfOhyQZS0r4f2hhXmQIbM4JKU+a9hSqrLCLqzDUW5VeUh4
	 ktVTwU0wtC8HLfhGK/5YSKBfNykN5fS/vzAdC3Yz8GmyPxga4I+u1bzy6TRrdWOPVC
	 xz4twRyQWELqDIjRu3MwyD5BqTI+l6YNaQ3foIMKjj2uc6YcMVIJMmr+xvxd19t/sP
	 93P5L0Nr5Ef//mIsMVSGS2IgfUW5M+pTpdeQZjrpKSYcRxYUv8OYHWy15E3VgwjRyP
	 f8BdP3cLcnvSXwfOd+BphHoPghMsxlDkgtv1Fwkr5uxcysXgee6tmiOatQBUwYwWpH
	 FnSTIclVSj+zQ==
From: Jakub Kicinski <kuba@kernel.org>
To: wintera@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	hidayath@linux.ibm.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	horms@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net/dibs: Fix UAF of dmb_clientid_arr after dibs_dev_del()
Date: Thu,  6 Aug 2026 09:06:02 -0700
Message-ID: <20260806160602.2694608-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804085848.3579518-1-wintera@linux.ibm.com>
References: <20260804085848.3579518-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/dibs: Fix UAF of dmb_clientid_arr after dibs_dev_del()

This moves the kfree() of dibs->dmb_clientid_arr out of dibs_dev_del() and
into dibs_dev_release(), so the array survives until the last device
reference is dropped.  The error paths in dibs_dev_add() are converted from
gotos to direct returns and no longer free the array.

> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
> index 14c3e2d84902e..f059fefb09bf8 100644
> --- a/drivers/dibs/dibs_main.c
> +++ b/drivers/dibs/dibs_main.c
> @@ -128,6 +128,7 @@ static void dibs_dev_release(struct device *dev)
>  
>  	dibs = container_of(dev, struct dibs_dev, dev);
>  
> +	kfree(dibs->dmb_clientid_arr);
>  	kfree(dibs);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the new ownership rule
here leave a double free of dibs->dmb_clientid_arr in the loopback probe
path?

After this change dibs_dev_release() is the sole owner of the buffer, while
dibs_lo_dev_probe() in drivers/dibs/dibs_loopback.c still frees it itself
when dibs_dev_add() fails:

drivers/dibs/dibs_loopback.c:dibs_lo_dev_probe() {
	...
	ret = dibs_dev_add(dibs);
	if (ret)
		goto err_reg;
	lo_dev = ldev;
	return 0;

err_reg:
	kfree(dibs->dmb_clientid_arr);
	/* pairs with dibs_dev_alloc() */
	put_device(&dibs->dev);
	kfree(ldev);
	...
}

dibs_dev_alloc() leaves the refcount at 1 via device_initialize(), and the
get_device()/put_device() pair inside device_add() nets to zero, so the
put_device() above drops the last reference and runs dibs_dev_release(),
which frees the same pointer a second time.

In the baseline this was already a double free (dibs_dev_add() freed the
array on its free_client_arr path and dibs_lo_dev_probe() freed it again),
so the defect predates the patch, but since this patch is the one that
redefines who owns dmb_clientid_arr, should the kfree() at err_reg in
dibs_lo_dev_probe() be dropped in the same change?

For comparison, drivers/s390/net/ism_drv.c:ism_probe() already relies only
on put_device() and has no explicit kfree, so the two callers of the same
exported API currently disagree about ownership:

drivers/s390/net/ism_drv.c:ism_probe() {
	...
err_ism:
	ism_dev_exit(ism);
err_dibs:
	/* pairs with dibs_dev_alloc() */
	put_device(&dibs->dev);
	...
}

Since this is tagged for stable, would it be worth also stating the new
caller contract in the changelog, i.e. that callers must only call
put_device() when dibs_dev_add() fails?

> @@ -194,12 +195,13 @@ int dibs_dev_add(struct dibs_dev *dibs)
>  
>  	ret = device_add(&dibs->dev);
>  	if (ret)
> -		goto free_client_arr;
> +		return ret;
>  
>  	ret = sysfs_create_group(&dibs->dev.kobj, &dibs_dev_attr_group);
>  	if (ret) {
>  		dev_err(&dibs->dev, "sysfs_create_group failed for dibs_dev\n");
> -		goto err_device_del;
> +		device_del(&dibs->dev);
> +		return ret;
>  	}

[Severity: High]
These are the two failure returns that reach the loopback err_reg path
described above: device_add() returning an error (-ENOMEM, or a
kobject_add()/duplicate-name failure) and sysfs_create_group() returning
-ENOMEM.  In both cases dmb_clientid_arr is still allocated and not NULLed,
so the caller-side kfree() and dibs_dev_release() both free it.  The
kzalloc-failure case is fine because the pointer is still NULL.

[Severity: Medium]
This is a pre-existing issue and not introduced by the patch, but the
changelog reasons about the placement of the allocation:

    Note that allocating in dibs_dev_add() instead of dibs_dev_alloc() is ok
    for now, because no dmbs can be registered before dibs_dev_add().

Does that reasoning also cover dibs->lock, which is initialized in the same
place?

drivers/dibs/dibs_main.c:dibs_dev_add() {
	max_dmbs = dibs->ops->max_dmbs();
	spin_lock_init(&dibs->lock);
	dibs->dmb_clientid_arr = kzalloc(max_dmbs, GFP_KERNEL);
	...
}

ism_probe() enables interrupts before that, via ism_dev_init() doing
request_irq(pci_irq_vector(pdev, 0), ism_handle_irq, ...) plus
register_sba()/register_ieq(), and only calls dibs_dev_add() afterwards.  In
that window dibs comes from kzalloc, so dibs->lock has never been
initialized and dmb_clientid_arr is NULL, yet the handler takes the lock and
indexes the array before any check:

drivers/s390/net/ism_drv.c:ism_handle_irq() {
	spin_lock(&dibs->lock);
	ism->sba->s = 0;
	...
		client_id = dibs->dmb_clientid_arr[bit];
		if (unlikely(client_id == NO_DIBS_CLIENT ||
			     !dibs->subs[client_id]))
			continue;
	...
}

The comment in ism_probe() says interrupts and events are ignored before
dibs_dev_add() adds the device to any clients, but that check happens on
dibs->subs[], after the lock acquisition and after the dmb_clientid_arr
dereference.  With CONFIG_DEBUG_SPINLOCK or lockdep this window would give
"spinlock bad magic" or "trying to register non-static key" from hardirq
context, and spin_lock_init() in dibs_dev_add() re-zeroing the lock while
the handler may hold it would void mutual exclusion.

Would moving spin_lock_init() and the allocation into dibs_dev_alloc() close
this window?

> @@ -214,13 +216,6 @@ int dibs_dev_add(struct dibs_dev *dibs)
>  	mutex_unlock(&dibs_dev_list.mutex);
>  
>  	return 0;
> -
> -err_device_del:
> -	device_del(&dibs->dev);
> -free_client_arr:
> -	kfree(dibs->dmb_clientid_arr);
> -	return ret;
> -
>  }
>  EXPORT_SYMBOL_GPL(dibs_dev_add);

[ ... ]
-- 
pw-bot: cr
