Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADF2AEEB;
	Wed, 30 Sep 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794672; cv=none; b=jAtnUHqp17EyJ7svL+Gc810IBGdxBqhaCiOtwcBTIdqURF/TC0fwhUGd1LfGCGC0yicuZp7THBYPCqKYGgzB1AAQh//xHma8ScYJI0Wj71fLMTL5CM+Efb7w2F1RZh7UCqPMvCNVZ5ZEvzEJJHgKZ33sav78oDOAS29WycUz+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794672; c=relaxed/simple;
	bh=7Ony82fPEbzDzFmqQoLKK2dAPV5EojmBxAswhxgh+YY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXEXAHk89YZ3uSioKItuBBrO144zniFRF0ATHi0QzR3apzeYtGpuyWfZIqM4oEqrEZ+XFzD4weDBPWfD0C3gTu9rO/F/9p+zgl5lrwcTLc0UEY4orlFHD8I4go523VPlInH6PWGOf4Flt1zRf7yqGya/O0/uljIAp5iCCzCkmjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=1Nejk1G/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dgBPdZNV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="1Nejk1G/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dgBPdZNV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 103021D00095;
	Wed, 30 Sep 2026 14:57:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 14:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790794667;
	 x=1790881067; bh=4+1ij5l7W1jL1mL16YFM/6fSOxhRkIh5R9gXWIIx9X8=; b=
	1Nejk1G/KcbI/9OtNiebfY8NlZmwutB+2fORtXfvyzISCIKU0wGmau+/VeOcpduW
	zOifYw1sAA+cFwQfeEICiMY9EgBAE0miaeLRoVeHwYi0aIUU9L/Gj2fDGDcnONf4
	R9wSFnhuQRL/6p7mmLQvYax9EY/bpj2FBltIycjFyokjIVnxrQ3c3lZJfLENWSZO
	dRH79uFJJ4QrBp9iWwDFhBcY73wy2ZFnyDKmjM84TUHlAMw/qHCOQUweb9zhsjOc
	O9usoC3gn3fI6iu9YZgxPbONv32wW4vTD3+9ugOWS1+rrl6bkiwot5frUlsR8oEt
	1+Oo8KE/E6kmHSE265XeSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790794667; x=
	1790881067; bh=4+1ij5l7W1jL1mL16YFM/6fSOxhRkIh5R9gXWIIx9X8=; b=d
	gBPdZNVWqT8Mq8e8RgRbK47LePOohlqROhJKr44Vlsjl3wDT6QpokCnnn6jhzDN+
	9eRaze/4q7vNr2P3d0KTcCJgIUgXsu3BR+S5MPiuWe0rsxcVrvwQjBO1Xug8i6na
	v+eCgd4xMKGf6szDFAn6Cg8rmfRHjkwcnJ4fvz4sEXEmRf4JjMWWQYWBtnh5BEj7
	CF8pRm+NOV2cWWP/4h56HB9M7CY18cbg1V31TWhvQPbIcAWMWouBpqq0WLJM1fp/
	JivGa8dcuXHEJIB6htbq5jl79dncidiQAVhZuuixG0P5RwGff7HBA59zx0MVxdYN
	ooazqqB5nGdGQ4z1UG5ag==
X-ME-Sender: <xms:q1u9aoKlGuMjx3GeLvDpOta4l_iWBwwOHpw2JFwLsF9HGTOyob_x-g>
    <xme:q1u9atAbtW851sEdS8M0TgD2LkNe7l-bL_rG12uqa5uuh_jL6Gtiw4d2JbHWvQryP
    CBci7ctsPVnqwnRC4nw51RK3VJr8tYXFynZEDdJUwYZfZKexA0pRMA>
X-ME-Received: <xmr:q1u9ahQAJn6sa1kNX-VZORlry0WQ3dEAUCEqFY3AXFMz-Vbjl6l7MnKyL35WUA>
X-ME-Proxy-Cause: dmFkZTFSqpLY/jlGjktZHd0L3zLtBQcBIJdttSofbU7LTPDSjuIL6O2FXr2JZvcfBLCGWZ
    k8h6a8z8TclHYwS0lFQnmDQbaeDuq5Tt4+UM6z8JzMnNH45ZgMUTzSX2urqxFB9iMl+/oj
    fEVhEOtCC3h3n8pxZiQyYVsiyg8R41lCGkpQTZIA3pYuR6qxg26tPfRIBbWeF0ul08q+29
    BQqc9qkTYhRLS3KAUUiVR9UXpV8NgwlQF3ZhRPE7aVMBD2vt4guTTRsNnC23nJftK6VScB
    kB5FkMUZnM9CreaDk0kOfun3gcoWqcZwnkl9QnzPNDTqM3LZ4PLLxT6pjs0ckZHicfTFog
    RMyPT/woUCDBy6TMMo18l2a3lP0Xoeunkqx+Uf0MQ3gHoMq8CbO5aaqd4VyV25KdawbMdx
    jkPiItlIekKV1O96oqQPT4VrEGsknJryJ3LrjH/ERCgmf+gkNYscGw9dnTm4tpNbQs6tCX
    XTM50EfvkYkxyzADK7Z5tdSt5dWz7cDGAwhebd2kcfhOY6qHcZUnrh+hMJdloVvDaglA4A
    2mn7p/hcPh0aBrG20UckftWOKy/KFSG/ZxYBLDNibv3fshAUZE1zrSHrzicLGykbQNhzUG
    5eSHWIbeSgqZsZIe606XOvolrdQ/95rh2l35vSSQvBuiPN1rM8KfXW5sGIKQ
X-ME-Proxy: <xmx:q1u9ampPsyBGVmq_gOgFrNw6SyAnJtD0NBtsnAPqbWppO0eOo7qHqw>
    <xmx:q1u9aiXzfTCFlWo1AIXvXHqssUC0q8GvZovkIpYtcapndmR0PIkbvQ>
    <xmx:q1u9as-uol2vVrmCN7JaP9wf0nEvmZF46vABGPzoJ66sJVtiNOKdtQ>
    <xmx:q1u9aiYhkitdd63gq_k-DJ-ax6RlM1RFUWVrmUECCM4HPqmLofbHyQ>
    <xmx:q1u9amamn2VG5Ok4H0xuRSIdwtGQIwa5aQxl45ICP3_OmZI9wLJC5ybP>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 14:57:46 -0400 (EDT)
Date: Wed, 30 Sep 2026 12:57:44 -0600
From: Alex Williamson <alex@shazbot.org>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
 alex@shazbot.org
Subject: Re: [PATCH v7 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
Message-ID: <20260930125744.2c03b68a@shazbot.org>
In-Reply-To: <20260922195141.94548-3-oelghoul@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
	<20260922195141.94548-3-oelghoul@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 15:51:39 -0400
Omar Elghoul <oelghoul@linux.ibm.com> wrote:

> Introduce the function zpci_fmb_reenable_device() that checks the state
> of function measurement and ensures it is enabled. Reset the counters to
> zero, disable, and re-enable the FMB if it was already enabled. Call
> this function from zpci_reenable_device().
> 
> Don't free the FMB buffer during disabling and reuse it when re-enabling
> measurement. Instead, free the buffer upon device teardown, allowing the
> same buffer to be reused in the enable path and add the bit fmb_enabled
> to struct zpci_dev. Audit the only consumer of zdev->fmb and update it
> to reflect the change in semantics.
> 
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h |  2 +
>  arch/s390/pci/pci.c         | 77 +++++++++++++++++++++++++++++--------
>  arch/s390/pci/pci_debug.c   |  2 +-
>  3 files changed, 63 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 88a125b92bdd..b8162f7a8968 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -175,6 +175,7 @@ struct zpci_dev {
>  	u8		util_str_avail	: 1;
>  	u8		tid_avail	: 1;
>  	u8		rtr_avail	: 1; /* Relaxed translation allowed */
> +	u8		fmb_enabled	: 1;

This appears safe, fmb_enabled seems to be the only runtime mutated
bitfield in this set, but it might be a good idea to flag it as such or
use a separate storage unit to avoid a tearing hazard in the future.
Thanks,

Alex
