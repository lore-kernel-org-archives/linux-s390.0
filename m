Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E578199943
	for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2024 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096029; cv=none; b=NRX7kSAox+cuDtU2yKZp6kCPesScC190TWm1EdBHv7JU2LuY5yp/sc2fyemFDm6zaiYhr1oJlooSpiHuk1mKW+eh+IYAVJqQmEEBXj20KrSpWJwisq0zVVTA2Lh9x7ENfsMQHYVGLxsxuBhCWqq+cXKNYSblJLMwr1cT+Z7lyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096029; c=relaxed/simple;
	bh=BeB0I5N9lmAH1/USVhzS2jrTuW+JT107L4SWdR0WNKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIyHogLsTDhhyFhcFt//W/EMYGZ8HRXT0QrQdVT6XvauCSGkToIdt4Xx4YbzXFcQxN0M0vsPYD1faTkrOogC27NmsG5GavY/Ob8u5USIb0nJGTS3pEkkFJfkOGOBzWClgZzYFpmgWhi17PtJoXUlT9xck9TICfs9DDCCDLAOqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxj+9SR4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxj+9SR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732096027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RQ/EL0J6kjGmTeoQldkQB/yJmR9CyO2pv3yRZbq8j84=;
	b=fxj+9SR4kWRFT4/nelYaba4R+NGH6c+6LWqHvsO3XuEH/jhwdOWZG3n9gTenyvRfMYjPZA
	7FSClvE6GDERYLgV6go3PKlyKBoQpAxbSz5wV7vQT50h6n+mvPNvW6KpLbRObqwV8VE8NT
	ztyBftS8fRfkzdr6MR3XRqM9tEZ+tVU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-Humkb_9bOb-2SPRao4GIRw-1; Wed,
 20 Nov 2024 04:47:03 -0500
X-MC-Unique: Humkb_9bOb-2SPRao4GIRw-1
X-Mimecast-MFC-AGG-ID: Humkb_9bOb-2SPRao4GIRw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 770D91955BCF;
	Wed, 20 Nov 2024 09:47:01 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE26530000DF;
	Wed, 20 Nov 2024 09:46:58 +0000 (UTC)
Date: Wed, 20 Nov 2024 17:46:54 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 06/11] fs/proc/vmcore: factor out freeing a list of
 vmcore ranges
Message-ID: <Zz2wDu9XskX1dgN7@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-7-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025151134.1275575-7-david@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> Let's factor it out into include/linux/crash_dump.h, from where we can
> use it also outside of vmcore.c later.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/proc/vmcore.c           |  9 +--------
>  include/linux/crash_dump.h | 11 +++++++++++
>  2 files changed, 12 insertions(+), 8 deletions(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 76fdc3fb8c0e..3e90416ee54e 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1568,14 +1568,7 @@ void vmcore_cleanup(void)
>  		proc_vmcore = NULL;
>  	}
>  
> -	/* clear the vmcore list. */
> -	while (!list_empty(&vmcore_list)) {
> -		struct vmcore_mem_node *m;
> -
> -		m = list_first_entry(&vmcore_list, struct vmcore_mem_node, list);
> -		list_del(&m->list);
> -		kfree(m);
> -	}
> +	vmcore_free_mem_nodes(&vmcore_list);
>  	free_elfcorebuf();
>  
>  	/* clear vmcore device dump list */
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index ae77049fc023..722dbcff7371 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -135,6 +135,17 @@ static inline int vmcore_alloc_add_mem_node(struct list_head *list,
>  	return 0;
>  }
>  
> +/* Free a list of vmcore memory nodes. */
> +static inline void vmcore_free_mem_nodes(struct list_head *list)
> +{
> +	struct vmcore_mem_node *m, *tmp;
> +
> +	list_for_each_entry_safe(m, tmp, list, list) {
> +		list_del(&m->list);
> +		kfree(m);
> +	}
> +}
> +
>  #else /* !CONFIG_CRASH_DUMP */
>  static inline bool is_kdump_kernel(void) { return false; }
>  #endif /* CONFIG_CRASH_DUMP */
> -- 
> 2.46.1
> 

