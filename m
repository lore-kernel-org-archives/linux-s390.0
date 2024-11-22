Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D42AE96
	for <linux-s390@vger.kernel.org>; Fri, 22 Nov 2024 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260693; cv=none; b=ewdNP6NTfxRutJ13TdqG8UEHWxe7oeRrCBek+epCfCyNssyk9hF9r4/iNpydBsL5KYOXFpTM3IA+X2kSKAMlqGtQgxx+RgOVsE8r1r4D5IWkB5Kt8oet9WSXNKcwTa5JnKwalcl5aojAJ/bXKAhpyBMcbuYYzfbd3dqm7hJ2Fcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260693; c=relaxed/simple;
	bh=HQvBfxRd8qJug47oyF/nl4DbLd5Lm22tQlEI+j4EkI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwqksJEQHPjrhTInt4JrQcmxwQXNcus+xjQro34dxHrv0ArHW1/8GocMNN2ptylZfFjTOxUmzp4qYUTi3rVHD4fnBKC+WEFmQ2hXL8n9x7Jqf29ugiXFSYFI7dEtxg4jcwgxx85lAgGG9MfVygj9syU6WLNSnfuu02qY53WicMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8gUn1cu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8gUn1cu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732260690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PXq9Wjiti00hPsb6uBFVS+EGZ67OZCcyDnwcfoAoCsg=;
	b=L8gUn1cuaPeEPv5GU4jo9q+JJztMmIBWRZIwv3oI80MAIfaN0yjQSKjEHDq/OP1yN5MwLw
	qnHieZRlIXfgEnl/NqMSRIHRFZNtS9oud+9Vqmn9pIB7qz/YfgS8rIOeg9Ow3gjuMEzXjh
	mgGD9fETSQWJpTl17qB1DvgoVjg2qCw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-sLMKtwRkP9C3ZZ084QJlQw-1; Fri,
 22 Nov 2024 02:31:28 -0500
X-MC-Unique: sLMKtwRkP9C3ZZ084QJlQw-1
X-Mimecast-MFC-AGG-ID: sLMKtwRkP9C3ZZ084QJlQw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8D46195608A;
	Fri, 22 Nov 2024 07:31:25 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA2AF19560A3;
	Fri, 22 Nov 2024 07:31:23 +0000 (UTC)
Date: Fri, 22 Nov 2024 15:31:19 +0800
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
Subject: Re: [PATCH v1 07/11] fs/proc/vmcore: introduce
 PROC_VMCORE_DEVICE_RAM to detect device RAM ranges in 2nd kernel
Message-ID: <Z0AzR2Yhl527wkbP@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-8-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025151134.1275575-8-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/25/24 at 05:11pm, David Hildenbrand wrote:
......snip...
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 3e90416ee54e..c332a9a4920b 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -69,6 +69,8 @@ static LIST_HEAD(vmcore_cb_list);
>  /* Whether the vmcore has been opened once. */
>  static bool vmcore_opened;
>  
> +static void vmcore_process_device_ram(struct vmcore_cb *cb);
> +
>  void register_vmcore_cb(struct vmcore_cb *cb)
>  {
>  	INIT_LIST_HEAD(&cb->next);
> @@ -80,6 +82,8 @@ void register_vmcore_cb(struct vmcore_cb *cb)
>  	 */
>  	if (vmcore_opened)
>  		pr_warn_once("Unexpected vmcore callback registration\n");
> +	else if (cb->get_device_ram)
> +		vmcore_process_device_ram(cb);

Global variable 'vmcore_opened' is used to indicate if /proc/vmcore is
opened. With &vmcore_mutex, we don't need to worry about concurrent
opening and modification. However, if people just open /proc/vmcore and
close it after checking, then s390 will miss the vmcore dumping, is it
acceptable?

>  	mutex_unlock(&vmcore_mutex);
>  }
>  EXPORT_SYMBOL_GPL(register_vmcore_cb);
> @@ -1511,6 +1515,158 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
......
> +
> +static void vmcore_process_device_ram(struct vmcore_cb *cb)
> +{
> +	unsigned char *e_ident = (unsigned char *)elfcorebuf;
> +	struct vmcore_mem_node *first, *m;
> +	LIST_HEAD(list);
> +	int count;
> +
> +	if (cb->get_device_ram(cb, &list)) {
> +		pr_err("Kdump: obtaining device ram ranges failed\n");
> +		return;
> +	}
> +	count = list_count_nodes(&list);
> +	if (!count)
> +		return;
> +
> +	/* We only support Elf64 dumps for now. */
> +	if (WARN_ON_ONCE(e_ident[EI_CLASS] != ELFCLASS64)) {
> +		pr_err("Kdump: device ram ranges only support Elf64\n");
> +		goto out_free;
> +	}

Only supporting Elf64 dumps seems to be a basic checking, do we need
to put it at the beginning of function? Otherwise, we spend efforts to
call cb->get_device_ram(), then fail.

> +
> +	/*
> +	 * For some reason these ranges are already know? Might happen
> +	 * with unusual register->unregister->register sequences; we'll simply
> +	 * sanity check using the first range.
> +	 */
> +	first = list_first_entry(&list, struct vmcore_mem_node, list);
> +	list_for_each_entry(m, &vmcore_list, list) {
> +		unsigned long long m_end = m->paddr + m->size;
> +		unsigned long long first_end = first->paddr + first->size;
> +
> +		if (first->paddr < m_end && m->paddr < first_end)
> +			goto out_free;
> +	}
> +
> +	/* If adding the mem nodes succeeds, they must not be freed. */
> +	if (!vmcore_add_device_ram_elf64(&list, count))
> +		return;
> +out_free:
> +	vmcore_free_mem_nodes(&list);
> +}
> +#else /* !CONFIG_PROC_VMCORE_DEVICE_RAM */
> +static void vmcore_process_device_ram(struct vmcore_cb *cb)
> +{
> +}
> +#endif /* CONFIG_PROC_VMCORE_DEVICE_RAM */
> +
>  /* Free all dumps in vmcore device dump list */
>  static void vmcore_free_device_dumps(void)
>  {
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 722dbcff7371..8e581a053d7f 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h

