Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455A1F3BAC
	for <linux-s390@vger.kernel.org>; Sat,  4 Apr 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775294403; cv=none; b=hs1yljs9Q13N7XVrfjTVlOcKVLgT1NXp2k3y0bXqgFF+V/+sxePiQwTJFWoUizw95HtpJcn9ROFbKF4pckjkDFVjzRm4zwEQIuodm3sPKoI2Cpr7LwhwBeu6nWEonpZEUo0VhMMZvpCbU+Gsr2NNUXuvUxz72srkihKjWq4Srwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775294403; c=relaxed/simple;
	bh=EIv7lYr1T7f/GDt0S/Td9JK5NwxiDBxh3MS7M5EUIdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5i79gbMYcQ8AoGRiXxB0XtqdvHMCvjGOSZVnCLUgdD1jWcTbD6lTpG5tnfI8aoBgk3M9szpLWKgKzIprB2wQCi43vzOKHq/1NhjGC93l+FdWLKhWEGwYLtKdDBDMkZtf28Q6X2ndAolRR32TYXCd0+uxajUMCNk8OVyvRzAf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Elm1KLkS; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Elm1KLkS"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2290346eec.1
        for <linux-s390@vger.kernel.org>; Sat, 04 Apr 2026 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775294401; x=1775899201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4D9KIHfQ19G+ih5n0VIDlQHW6gYQM9spmrNFkW8GpA=;
        b=Elm1KLkSxBChhGjXkYEzfmsjYyDAR+6DwGIVs98jb6IKFddd7aW1ULpxysF0dVdzB6
         ssk5N/00z3oT2H9foE43/7V4/tyrEakEO1UJ6tZ5qNILoOkti1NZzm+Czz8E6XpXDa9+
         +hAuYNqW28v6qMJ2LOPQ6JMRE4vfjTYJwR8EEGH/UHedyPAzBvSSAwLjzZGe35UO/QUh
         dAHr8mfe/SkAZlQFcdyKN6RB/41Qrw0VQJ0bIrWnbGVXe/5Ju2nkTvomPTfqUIT82XxN
         O4kCri2UHzuUkyL49gQdyGmx6yMZvl7w/euUP0HLLwchL3cmB4JSoJElo65AqFH3fnyq
         XRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775294401; x=1775899201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m4D9KIHfQ19G+ih5n0VIDlQHW6gYQM9spmrNFkW8GpA=;
        b=FjNRuwI+MvvGxpLnqAwXaiwFMKSMbDltaCYNze6+eCF1pZegS4aCPdogZ4vM3H5OGy
         tJS9CkgpLy22IUYpGuCtaZ9xJdl0CPpmeFMBPXhjVP4EQzit11LfwsVwrN6tCw6w3Xkf
         XAiysDPtHm16kHpm0XvckE92sT4Sm9Kv24i3+tb5aKk5CF+gP8u0Ynnz+Hwq9Lx3N9mD
         boPkAOY3BaHmA46Ac5cb6AU1hFJjIapjO/4W04E34SUT+NKx1bzMxvo71TVadvbv6YUp
         XFJ7TyxJfAQcEO3f8GcgPQEoeKKExO8qXZ3nAZXCLLxwJXTBSWm2P6vh9om9e02nef8b
         VJww==
X-Forwarded-Encrypted: i=1; AJvYcCVZCq2p9m6+2qLO+X66y0+x+oudWYQIYXKVmiqJSnV3jIbH+lt11Ss58JyjnVo2e2viDJr2YNLm7p8K@vger.kernel.org
X-Gm-Message-State: AOJu0YylSdlNG5hlsQxP89EOnbF6JhD5xvruMCyLskqHmIVKHHKjkaWE
	loFygDFp39LamM1V07d0+zxBH/CdmB8PUiKEswzgqnQv66tZtYey0iCc
X-Gm-Gg: AeBDievpZ1VQafoKf57or6a9i11cz48XxDJgjo3RiQLXO/zRCOy629TJcgvLVkxBQqt
	fxbCLDdx+cFpGhABbSkXKhBmwKe61dtNP++jZs3MNvE/5EKLPB4fRT6HIfXTrwqx6CJ5cbOky4Z
	VEJAwbXThJLj4iGDqs5WfOibdwiFiS+23BblY/h9gotaSp+k68sW8a+Fc6VrlAI/vb890+4eCN2
	VUlsT9kej2Zv/yGHGKi2w8IQcsCGL3gVT9Q9WAVC3WSTnGULN9VT39VQTiuW9l2NllayBauwQA1
	hzu5k737TQFntf3rFSk6INwEFfSk+w+oVzrv/4PQd8KNcQfJ+j9jTfxHrF3xi3maBRbqLGkJyOX
	BHLezcqlTb+7n8tm6skFpHNF3X5gDNUyQehanCPA2xYEi5kFzApqjFjGNBPAM3OLWabitfUP/up
	M/8K+vz9/GFSkbEu581g7Uz9w=
X-Received: by 2002:a05:7300:a287:b0:2c1:74ad:2cd7 with SMTP id 5a478bee46e88-2cbfbf760c4mr2791873eec.27.1775294400761;
        Sat, 04 Apr 2026 02:20:00 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm7176920eec.5.2026.04.04.02.19.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Apr 2026 02:20:00 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: 21cnbao@gmail.com
Cc: akpm@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	surenb@google.com,
	willy@infradead.org,
	wang lian <lianux.mm@gmail.com>,
	Wang Lian <wanglian@kylinos.cn>,
	Kunwu Chan <chentao@kylinos.cn>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying page faults after I/O
Date: Sat,  4 Apr 2026 17:19:32 +0800
Message-ID: <20260404091936.51961-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAGsJ_4wnwAet4svDrxT4sTdp24sweAU-2VyYn3iNPOoaKdXxPw@mail.gmail.com>
References: <CAGsJ_4wnwAet4svDrxT4sTdp24sweAU-2VyYn3iNPOoaKdXxPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi Barry,

> If either you or Matthew have a reproducer for this issue, I’d be
> happy to try it out.

Kunwu and I evaluated this series ("mm: continue using per-VMA lock when
retrying page faults after I/O") under a stress scenario specifically
designed to expose the retry behavior in filemap_fault(). This models
the exact situation described by Matthew Wilcox [1], where retries after
I/O fail to make forward progress under memory pressure.

The scenario targets the critical window between I/O completion and
mmap_lock reacquisition. This workload deliberately includes frequent
mmap/munmap operations to simulate a highly contended mmap_lock
environment alongside severe memory pressure (1GB memcg limit). Under
this pressure, folios instantiated by the I/O can be aggressively
reclaimed before the delayed task can re-acquire the lock and install
the PTE, forcing retries to repeat the entire work.

To make this behavior reproducible, we constructed a stress setup that
intentionally extends this interval:
* 256-core x86 system
* 1GB memory cgroup
* 500 threads continuously faulting on a 16MB file

The core reproducer and the execution command are provided below:

#define _GNU_SOURCE 
#include <errno.h> 
#include <fcntl.h> 
#include <pthread.h> 
#include <stdatomic.h> 
#include <stdint.h> 
#include <stdio.h> 
#include <stdlib.h> 
#include <string.h> 
#include <sys/mman.h> 
#include <unistd.h> 
#include <time.h> 

#define THREADS 500 
#define FILE_SIZE (16 * 1024 * 1024) /* 16MB */ 

static _Atomic int g_stop = 0; 
#define RUN_SECONDS 600 

struct worker_arg { 
        long id; 
        uint64_t *counts; 
}; 

void *worker(void *arg) 
{ 
        struct worker_arg *wa = (struct worker_arg *)arg; 
        long id = wa->id; 
        char path[64]; 
        uint64_t local_rounds = 0; 

        snprintf(path, sizeof(path), "./test_file_%d_%ld.dat", 
                 getpid(), id); 
        int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666); 
        if (fd < 0) return NULL; 
        if (ftruncate(fd, FILE_SIZE) < 0) { 
                close(fd); return NULL; 
        } 

        while (!atomic_load_explicit(&g_stop, memory_order_relaxed)) { 
                char *f_map = mmap(NULL, FILE_SIZE, PROT_READ, 
                                   MAP_SHARED, fd, 0); 
                if (f_map != MAP_FAILED) { 
                        /* Pure page cache thrashing */ 
                        for (int i = 0; i < FILE_SIZE; i += 4096) { 
                                volatile unsigned char c = 
                                        (unsigned char)f_map[i]; 
                                (void)c; 
                        } 
                        munmap(f_map, FILE_SIZE); 
                        local_rounds++; 
                } 
        } 
        wa->counts[id] = local_rounds; 
        close(fd); 
        unlink(path); 
        return NULL; 
} 

int main(void) 
{ 
        printf("Pure File Thrashing Started. PID: %d\n", getpid()); 
        pthread_t t[THREADS]; 
        uint64_t local_counts[THREADS]; 
        memset(local_counts, 0, sizeof(local_counts)); 
        struct worker_arg args[THREADS]; 

        for (long i = 0; i < THREADS; i++) { 
                args[i].id = i; 
                args[i].counts = local_counts; 
                pthread_create(&t[i], NULL, worker, &args[i]); 
        } 

        sleep(RUN_SECONDS); 
        atomic_store_explicit(&g_stop, 1, memory_order_relaxed); 

        for (int i = 0; i < THREADS; i++) pthread_join(t[i], NULL); 

        uint64_t total = 0; 
        for (int i = 0; i < THREADS; i++) total += local_counts[i]; 

        printf("Total rounds     : %llu\n", (unsigned long long)total); 
        printf("Throughput       : %.2f rounds/sec\n", 
               (double)total / RUN_SECONDS); 
        return 0; 
}

Command line used for the test:
systemd-run --scope -p MemoryHigh=1G -p MemoryMax=1.2G -p MemorySwapMax=0 \
--unit=mmap-thrash-$$ ./mmap_lock & \
TEST_PID=$!

We also added temporary counters in page fault retries [2]:
- RETRY_IO_MISS   : folio not present after I/O completion
- RETRY_MMAP_DROP : retry fallback due to waiting for I/O

We report representative runs from our 600-second test iterations 
(kernel v7.0-rc3):

| Case                | Total Rounds | Throughput | Miss/Drop(%) | RETRY_MMAP_DROP | RETRY_IO_MISS |
| ------------------- | ------------ | ---------- | ------------ | --------------- | ------------- |
| Baseline (Run 1)    | 22,711       | 37.85 /s   | 45.04        | 970,078         | 436,956       |
| Baseline (Run 2)    | 23,530       | 39.22 /s   | 44.96        | 972,043         | 437,077       |
| With Series (Run A) | 54,428       | 90.71 /s   | 1.69         | 1,204,124       | 20,398        |
| With Series (Run B) | 35,949       | 59.91 /s   | 0.03         | 327,023         | 99            |


Notes:
1. Throughput Improvement: During the 600-second testing window, overall 
   workload throughput can more than double (e.g., Run A jumped from ~38 
   to 90.71 rounds/sec).
2. Elimination of Race Condition: Without the patch, ~45% of retries 
   were invalid because newly fetched folios were evicted during the 
   mmap_lock reacquisition delay. With the per-VMA retry path, the 
   invalidation ratio plummeted to near zero (0.03% - 1.69%).
3. Counter Scaling and Variance: In Run A, because the I/O wait 
   bottleneck is eliminated, the threads advance much faster. Thus, the 
   absolute number of mmap_lock drops naturally scales up with the 
   increased throughput. In Run B, the primary bottleneck shifts to the 
   mmap write-lock contention (lock convoying), causing throughput and 
   total drops to fluctuate. Crucially, the Miss/Drop ratio remains near 
   zero regardless of this variance.

Without this series, almost half of the retries fail to observe
completed I/O results, causing severe CPU and I/O waste. With the
finer-grained VMA lock, the faulting threads bypass the heavily
contended mmap_lock entirely during retries, completing the fault
almost instantly.

This scenario perfectly aligns with the exact concern raised, and these
results show that the patch not only successfully eliminates the retry
inefficiency but also tangibly boosts macro-level system throughput.

[1] https://lore.kernel.org/linux-mm/aSip2mWX13sqPW_l@casper.infradead.org/
[2] https://github.com/lianux-mm/ioretry_test/

Tested-by: Wang Lian <wanglian@kylinos.cn>
Tested-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Wang Lian <lianux.mm@gmail.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

--
Best Regards,
wang lian
