From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] perf/tool: Fix usage of trace events with '-' in trace
 system name.
Date: Tue, 25 Mar 2014 11:15:29 +0100
Message-ID: <53315741.9010508@redhat.com>
References: <1395694140-43447-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395694140-43447-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-kernel@vger.kernel.org, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 24/03/2014 21:49, Christian Borntraeger ha scritto:
>  event_legacy_tracepoint:
> +PE_NAME '-' PE_NAME ':' PE_NAME
> +{
> +	struct parse_events_evlist *data = _data;
> +	struct list_head *list;
> +	char sys_name[strlen($1) + strlen($3) + 2];
> +	sprintf(&sys_name, "%s-%s", $1, $3);
> +
> +	ALLOC_LIST(list);
> +	ABORT_ON(parse_events_add_tracepoint(list, &data->idx, &sys_name, $5));
> +	$$ = list;
> +}

Why isn't '-' part of PE_NAME?

Paolo
