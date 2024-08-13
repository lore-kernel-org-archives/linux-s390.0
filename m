Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026E19EEB4;
	Tue, 13 Aug 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562995; cv=none; b=EFAM7gpIYa1EHMfKcUe+I0pqX71ONQ6oNMsts72aKXfgTCVv5ncqcr2oHOlqw+4HXsh/EHxsP+FJz+MDNS3Nb+XjloLmIn7E7yguKTS6pBXUMwlbF6b8e0nv45pIqsHAiTt3NIGf7Lg2ZfC7pqUXxIY2a1i6rjLWLB+It4szPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562995; c=relaxed/simple;
	bh=MNcxMgKtj9ULiS/BCsWkbHfiecDY5rHuA94v/y5yRIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8PuCa0RMlmaScS3R2F1kQPKhqnfcEXUbwl/EAOi+gjKVZhrekUqCfBKfg9krN40rrCjZc3eONNZeuig3sEHPhE72qZhsAMbzpNre19s9VunkH8VNJFe76sBfM8tXnixbPtvA+BXHQ9QMfdwhP7/VGk6x9epe/8rZ046gVjBCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v5/aX8cr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v5/aX8cr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631DAC4AF0B;
	Tue, 13 Aug 2024 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723562994;
	bh=MNcxMgKtj9ULiS/BCsWkbHfiecDY5rHuA94v/y5yRIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v5/aX8crUazrJfAKWLoHmHyoyfP8cc/NWNInxayRXTkYICg9VSnxWLbvEbxf46Q6H
	 sv/33VfnCu1xgpqQv7XYuPW7iV8O9Moi9ip3KyNvRD1lbNsr8tNsx4c4kFKJK5SMCB
	 CSSZE/K2bjiUdfZecKxcaP0GcN8/JPPeAs/ip2z4=
Date: Tue, 13 Aug 2024 17:29:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/iucv: Fix vargs handling in iucv_alloc_device()
Message-ID: <2024081332-unblock-absinthe-1c26@gregkh>
References: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
 <patch-2.thread-d8267b.git-d8267bded9e9.your-ad-here.call-01723545029-ext-2515@work.hours>
 <2024081331-bonnet-fiftieth-9a14@gregkh>
 <your-ad-here.call-01723549827-ext-8444@work.hours>
 <2024081319-patriarch-brutishly-653f@gregkh>
 <221ba279-e48b-4002-9530-c6186e3e8042@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221ba279-e48b-4002-9530-c6186e3e8042@linux.ibm.com>

On Tue, Aug 13, 2024 at 03:35:48PM +0200, Alexandra Winter wrote:
> 
> 
> On 13.08.24 14:43, Greg Kroah-Hartman wrote:
> >>> I don't understand, why can't dev_set_name() be called here?
> >>>
> [...]
> > 
> > But step back, why is this needed at all anyway?  No other subsystem or
> > driver needs/wants this, what makes this api so special?  Why not figure
> > out your name beforehand?
> > 
> > thanks,
> 
> 
> Vasily, the following update to Heiko's patch does not touch lib/kobject.c
> According to a quick test it still solves the original issue and does compile
> with W=1 and iucv as a module.
> 
> diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> index 64102a31b569..6a819ba4ccab 100644
> --- a/net/iucv/iucv.c
> +++ b/net/iucv/iucv.c
> @@ -86,13 +86,17 @@ struct device *iucv_alloc_device(const struct attribute_group **attrs,
>  {
>         struct device *dev;
>         va_list vargs;
> +       char buf[20];
>         int rc;
> 
>         dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>         if (!dev)
>                 goto out_error;
>         va_start(vargs, fmt);
> -       rc = kobject_set_name_vargs(&dev->kobj, fmt, vargs);
> +       rc = vsnprintf(buf, 20, fmt, vargs);
> +       if (!rc)
> +               rc = dev_set_name(dev, buf);

This looks best, let's not create a core function that no one has ever
needed yet just for one user :)

thanks,

greg k-h
