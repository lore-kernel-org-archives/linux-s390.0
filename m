Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF561343D6E;
	Wed, 26 Nov 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178641; cv=none; b=mIHPdZuMNClgYp1ASKkPdf4xU7zzBSd1Px34HVe+Fvxb7sNXOCSMbN08Dxb7Pl/bCaznGkufMDs3VlwwOnAqa3WsYnPlW7WnvlFM+QjwznZ8t1OHnzOYFfhsfrP59WWIV/GLVu9xbsOJHbCVUUQI0VZChH73HJiUGxw0kjPTGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178641; c=relaxed/simple;
	bh=RH4S1CQB4lYvLkgGH0dLjNn3jqZOapE3plYMmKIVrRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZS6U7/UtllYQ1Kdb0TZ9RLdSqVGZHfexWXEgXPUioCUfSlM1Wjd4dylW/KQC58P5iLzZJogAfn0R2BZvOGEvdDUucSPM3iXPxpatfD3HuEgGjxjXfoXWbOZ2sqzA8pXahpUB0QRRasKta7ffRFSLPopFb1QK10RvI/p6z7pFy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9DBF65A877;
	Wed, 26 Nov 2025 17:37:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 51CE02002E;
	Wed, 26 Nov 2025 17:37:09 +0000 (UTC)
Date: Wed, 26 Nov 2025 12:37:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: acme@kernel.org, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-perf-users@vger.kernel.org, agordeev@linux.ibm.com,
 gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
 japo@linux.ibm.com
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
Message-ID: <20251126123755.47aa3f11@gandalf.local.home>
In-Reply-To: <20251126121229.0638407b@gandalf.local.home>
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
	<aRvSv03cqarM5dY9@google.com>
	<d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
	<aRwVifZ_-7puFUVC@google.com>
	<20251118132451.29a35127@gandalf.local.home>
	<aR1JXlhJ8rC8Ujb3@google.com>
	<20251119125903.417f595e@gandalf.local.home>
	<aR5mTLRWA-SLAFUM@google.com>
	<a7a5f95b-25e0-4816-9d0b-04d955c95821@linux.ibm.com>
	<20251126102401.37af98bb@gandalf.local.home>
	<20251126121229.0638407b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tjnygmxqa8iteswjbfyzg7fstimxs7xf
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 51CE02002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+6Hkmy1CHwfQbZlBdsFmgajhk1Ua9CLak=
X-HE-Tag: 1764178629-337889
X-HE-Meta: U2FsdGVkX18eoMIb31FsykHAP9ARgpCuFJ10+e0JjHBEeMP5P1x/tSZ1OzzSUp0LSdaLtqMoIs5NWJbgop+P1UcWRrY0cvg09Jx1VGWjCHdmNi/Ednv0bIeT0RgDvfqDA+8jDJ1g82JEy04924S6+KYsBcEGdNCiNVv/ha1DvdDoy6kYC2aD/ZtfSI5PbTUiKo1C4s4950PpTYP+6mJgnUkRMfhnQT7NOO7k+f7oCt0bum89Yh2g6kgDu3Sqav3uX3leqBwFHwxiQkRJY+clSfnWemWZrVyDa+4jJPao8fJB8ohSWgVxrzF/imffeQ1EV4nAtYaS7Jw6QJ6YM5IRDslSM/QI8BLP0cpEOUOYRA3aOg/FKndiQLUCABeWY9CK

On Wed, 26 Nov 2025 12:12:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Arnaldo,
> 
> How can I make perf trace not confused by the extra fields in the system
> call trace events?
> 
> Ftrace can now show the contents of the system call user space buffers, but
> it appears that this breaks perf!!!
> 
> system: syscalls
> name: sys_enter_write
> ID: 791
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
> 	field:unsigned int fd;	offset:16;	size:8;	signed:0;
> 	field:const char * buf;	offset:24;	size:8;	signed:0;
> 	field:size_t count;	offset:32;	size:8;	signed:0;
> 	field:__data_loc char[] __buf_val;	offset:40;	size:4;	signed:0;
> 
> That new __buf_val appears to confuse perf, but I'm having a hell of a time
> trying to figure out where it reads it!
> 

Hmm, it gets less confused (at least it doesn't crash), when I don't have
perf read the extra values.

Thomas, if you add the below patch, does it fix things for you?

-- Steve

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e96d0063cbcf..add809d226dc 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1403,7 +1403,6 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	struct hlist_head *head;
 	unsigned long args[6];
 	bool valid_prog_array;
-	bool mayfault;
 	char *user_ptr;
 	int user_sizes[SYSCALL_FAULT_MAX_CNT] = {};
 	int buf_size = CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT;
@@ -1431,15 +1430,6 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
 	syscall_get_arguments(current, regs, args);
 
-	/* Check if this syscall event faults in user space memory */
-	mayfault = sys_data->user_mask != 0;
-
-	if (mayfault) {
-		if (syscall_get_data(sys_data, args, &user_ptr,
-				     &size, user_sizes, &uargs, buf_size) < 0)
-			return;
-	}
-
 	head = this_cpu_ptr(sys_data->enter_event->perf_events);
 	valid_prog_array = bpf_prog_array_valid(sys_data->enter_event);
 	if (!valid_prog_array && hlist_empty(head))
@@ -1457,9 +1447,6 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	rec->nr = syscall_nr;
 	memcpy(&rec->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
-	if (mayfault)
-		syscall_put_data(sys_data, rec, user_ptr, size, user_sizes, uargs);
-
 	if ((valid_prog_array &&
 	     !perf_call_bpf_enter(sys_data->enter_event, fake_regs, sys_data, rec)) ||
 	    hlist_empty(head)) {
