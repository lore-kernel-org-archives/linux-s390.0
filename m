From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf/tool: Fix usage of trace events with '-' in trace
 system name.
Date: Thu, 17 Apr 2014 13:32:21 +0200
Message-ID: <20140417113221.GA7422@krava.brq.redhat.com>
References: <1395694140-43447-1-git-send-email-borntraeger@de.ibm.com>
 <53315741.9010508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53315741.9010508@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-kernel@vger.kernel.org, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Mar 25, 2014 at 11:15:29AM +0100, Paolo Bonzini wrote:
> Il 24/03/2014 21:49, Christian Borntraeger ha scritto:
> > event_legacy_tracepoint:
> >+PE_NAME '-' PE_NAME ':' PE_NAME
> >+{
> >+	struct parse_events_evlist *data = _data;
> >+	struct list_head *list;
> >+	char sys_name[strlen($1) + strlen($3) + 2];
> >+	sprintf(&sys_name, "%s-%s", $1, $3);
> >+
> >+	ALLOC_LIST(list);
> >+	ABORT_ON(parse_events_add_tracepoint(list, &data->idx, &sys_name, $5));
> >+	$$ = list;
> >+}
> 
> Why isn't '-' part of PE_NAME?

hi Paolo ;-)

because it screws cache events parsing.. we need some code factoring
in this part

Acked-by: Jiri Olsa <jolsa@redhat.com>

it'd be nice to add test to tests/parse-events.c, probably s390 specific,
because the parsing code touches the tracepoint format file

thanks,
jirka
