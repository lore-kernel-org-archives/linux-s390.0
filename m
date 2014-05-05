From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 11/11] perf kvm: add stat support on s390
Date: Mon, 05 May 2014 12:43:12 +0200
Message-ID: <53676B40.1050609@de.ibm.com>
References: <1398417153-57347-1-git-send-email-borntraeger@de.ibm.com> <1398417153-57347-12-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1398417153-57347-12-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Olsa <jolsa@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>, David Ahern <dsahern@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On 25/04/14 11:12, Christian Borntraeger wrote:
> +#if defined(__i386__) || defined(__x86_64__)
>  	else if (!strcmp(kvm->report_event, "mmio"))
>  		kvm->events_ops = &mmio_events;
>  	else if (!strcmp(kvm->report_event, "ioport"))
>  		kvm->events_ops = &ioport_events;
> +#endif

To address Davids review, the next version will have this hunk as well:

diff --git a/tools/perf/Documentation/perf-kvm.txt b/tools/perf/Documentation/perf-kvm.txt
index 52276a6..e974749 100644
--- a/tools/perf/Documentation/perf-kvm.txt
+++ b/tools/perf/Documentation/perf-kvm.txt
@@ -103,8 +103,8 @@ STAT REPORT OPTIONS
        analyze events which occures on this vcpu. (default: all vcpus)
 
 --event=<value>::
-       event to be analyzed. Possible values: vmexit, mmio, ioport.
-       (default: vmexit)
+       event to be analyzed. Possible values: vmexit, mmio (x86 only),
+       ioport (x86 only). (default: vmexit)
 -k::
 --key=<value>::
        Sorting key. Possible values: sample (default, sort by samples
