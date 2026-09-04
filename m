Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925074457C1;
	Fri,  4 Sep 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515523; cv=none; b=uMR0hYO4Q4HsOlLWRlhTTPR1him5GgtsY9Mt7XCQXo1yaexgaotPKh3oPx9NAEPnM+iHv5ud6QSltVX2OFvWh1NjkXncdpYT46xhrHVG4NE2WvEwGCoRdGqvETI7S/hGjwF8ZRk5f/XXwifKQVK0ABtuFRzXxc4/sdOEzw/4gNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515523; c=relaxed/simple;
	bh=gLJ6khSR95EI+IMzmip515XkqQgVxkPnwrEB+rkVUPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NsVSz8Lfc5iXqFDiF02Y/RwXfJsdLuWxi3cOZuIAWyMINQVcyEE+IiAsraYVTbAkcCcYgARgdFo99xs9BYdajPxO9gqOVmozX988s4BbL1R+PtwENvwL8VC1bxhDH4Iowc6Jsqlp62CYCohCqwWTO1oqlwZRDTOrzUczVjfX9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+ssUijI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+ssUijI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7D11F00A3D;
	Fri,  4 Sep 2026 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515521;
	bh=tDVBGS/NFBTWr+9CMzXV7kPesa9O9qcZhDDeHpN3maU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+ssUijICgq4MrbUjuZA6BLC/Vkj/U1pz4gUnLzxXdwmJ+Y0vo4rXd0dbi/B2Zv6F
	 u6J/lNJiUOsLvhKlbVduFv/j66S5z80CNA7/4q90nXn6uXqWwOS6UaFtaJQIUxsoPJ
	 rFrtgclXuhqbpcTVMcJbxZz3N9LSD0NbgzyhjnD7CFtkPu9qHBpvZVKIMnlgINojes
	 dwA528/dnN7GynNL7byIri1s6jgc1W4PYmkRG9pfLv7C1CtVZy47bbvwmHxHFqfXNr
	 aghcLq2x8MsojDqtwl6fwfjM3ExZKVZLkv6mWFgyv3+WX6eJSVeLWYtOeJYeamkLvy
	 94cVaSd6uiqTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] s390/vfio-ap: Fix leak of pinned NIB and
 registered GISC in vfio_ap_irq_enable/disable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260904093435.1161402-2-akrowiak@linux.ibm.com>
References: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
 <20260904093435.1161402-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:51:59 +0000
Message-Id: <20260904095200.0E7D11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Guest-reachable WARN_ONCE macros violate KVM guidelines and can ca=
use a host denial of service (DoS) under panic_on_warn.

Pre-existing issues:
- [High] Pinned NIB page and registered GISC are permanently leaked when a =
queue is removed from the host AP configuration or becomes physically unava=
ilable.
--

commit ea9124e6c06c371c42de8146e0e3493413dc0829
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
s390/vfio-ap: Fix leak of pinned NIB and registered GISC in vfio_ap_irq_ena=
ble/disable()

This commit updates the interrupt enable and disable handlers for vfio_ap
to correctly manage pinned NIB pages and GISC registrations. It introduces=
=20
an asynchronous wait process for interrupt clearing to prevent wild DMA=20
writes, leaving resources allocated if the hardware doesn't confirm the=20
operation.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 940c0ff668bee..383ec9f5c8107 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -257,12 +269,15 @@ static void vfio_ap_wait_for_irqclear(int apqn)
>  		default:
>  			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
>  				  status.response_code, apqn);
> -			return;
> +			return -ENODEV;
>  		}
>  	} while (--retry);
> =20
> -	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
> -		  __func__, status.response_code, apqn);
> +	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts disabl=
ed for %02x.%04x\n",
> +		  __func__, status.response_code,
> +		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
> +
> +	return -ETIMEDOUT;
>  }

[Severity: High]
Does this allow an unprivileged guest to trigger a host panic?

According to KVM subsystem guidelines, guest-reachable WARN_ON or WARN_ONCE
macros are prohibited because they can crash the host kernel on systems
configured with panic_on_warn.

If a guest forces a delay by issuing a ZAPQ reset (which can take up to
2000ms), and immediately follows it with a PQAP-AQIC disable instruction,
this 100ms TAPQ polling loop (5 retries * 20ms) will time out.=20

Could this be converted to pr_warn_once() to avoid host denial of service?

[ ... ]

> @@ -326,18 +372,47 @@ static struct ap_queue_status vfio_ap_irq_disable(s=
truct vfio_ap_queue *q)
>  		case AP_RESPONSE_Q_NOT_AVAIL:
>  		case AP_RESPONSE_DECONFIGURED:
>  		case AP_RESPONSE_CHECKSTOPPED:
> +			/* AP not operational; no further interrupts possible */
> +			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
> +				  status.response_code);
> +			goto end_free;
>  		case AP_RESPONSE_INVALID_ADDRESS:
>  		default:
> -			/* All cases in default means AP not operational */
> +			/*
> +			 * The AQIC disable was rejected; IRQ is still enabled
> +			 * and the hardware still holds the NIB address. Do not
> +			 * free resources.
> +			 */
>  			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
>  				  status.response_code);
> -			goto end_free;
> +			goto end_fail;
>  		}
>  	} while (retries--);

[Severity: High]
Does this share the same risk of triggering a host panic as the warning abo=
ve?

Similar to the timeout case, if the AP returns statuses like DECONFIGURED
or CHECKSTOPPED, this guest-reachable path triggers a WARN_ONCE. Should
these be converted to pr_warn_once() to prevent a potential host DoS?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does the vfio_ap driver leak
the pinned NIB page and registered GISC when a queue is physically removed
or becomes unavailable?

Looking at vfio_ap_mdev_remove_queue(), if a queue with active interrupts is
removed from the host AP configuration, the bit test fails and we skip
calling vfio_ap_mdev_reset_queue(q):

	/*
	 * If the queue is not in the host's AP configuration, then resetting
	 * it will fail with response code 01, (APQN not valid); so, let's make
	 * sure it is in the host's config.
	 */
	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
		vfio_ap_mdev_reset_queue(q);
		flush_work(&q->reset_work);
	}

done:
	if (matrix_mdev)
		vfio_ap_unlink_queue_fr_mdev(q);

	dev_set_drvdata(&apdev->device, NULL);
	kfree(q);

Because the reset is bypassed, vfio_ap_free_aqic_resources(q) is never
called, permanently leaking the page and KVM routing entries.

Similarly, in vfio_ap_mdev_reset_queue():

	default:
		WARN(true,
		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=3D%u\n",
		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
		     status.response_code);
	}

If ap_zapq() returns AP_RESPONSE_Q_NOT_AVAIL (0x01) because the queue is=20
physically unavailable, the default case is hit. It logs a warning but fail=
s=20
to call vfio_ap_free_aqic_resources(q), leaking the resources.

Could this lead to memory exhaustion and depletion of KVM ISCs over time if
devices are dynamically reconfigured?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904093435.1161=
402-1-akrowiak@linux.ibm.com?part=3D1
