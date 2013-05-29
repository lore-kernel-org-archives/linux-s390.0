From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] arch: s390: appldata: using strncpy() and strnlen()
 instead of sprintf()
Date: Wed, 29 May 2013 09:28:43 +0800
Message-ID: <51A559CB.3020804@asianux.com>
References: <51A48EE9.2040401@asianux.com> <51A32D81.2010105@asianux.com> <51A2CC07.5010100@asianux.com> <CAMuHMdXTW3QOxfAfqQXdbSpP4R83srFf7eMfu5fA-75S_Mujsg@mail.gmail.com> <4310.1369736553@warthog.procyon.org.uk> <5895.1369743429@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <5895.1369743429@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, jang@linux.vnet.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 05/28/2013 08:17 PM, David Howells wrote:
> Chen Gang <gang.chen@asianux.com> wrote:
> 
>> Your suggestion will improve the speed, but may merge "transferring
>> 'protocol' data" and "processing 'protocol' data" together.
> 
> Look at it this way: You're having to step very carefully because you are
> fully expecting the strings not to be NUL-terminated.  Therefore you probably
> avoid using string functions if you can.
> 
> In fact, looking at the code, why are you copying the data through an
> intermediate buffer at all?  Why not just copy directly to userspace:
> 
> 	int len;
> 	char buf[2];
> 
> 	if (!*lenp || *ppos) {
> 		*lenp = 0;
> 		return 0;
> 	}
> 	if (!write) {
> -		len = sprintf(buf, appldata_timer_active ? "1\n" : "0\n");
> +		const char *ptr = appldata_timer_active ? "1\n" : "0\n";
> +		size_t len = 2;
> 		if (len > *lenp)
> 			len = *lenp;
> 		if (copy_to_user(buffer, buf, len))

may: "if (copy_to_user(buffer, ptr, len))" ?

:-)

> 			return -EFAULT;
> 		goto out;
> 	}
> 
> Put like that, it's fairly obvious what is going on.
> 

It seems well fixed (still independent of processing 'protocol' data).

:-)


And how about below:

-------------------------------diff begin------------------------------


diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index bae0f40..27f200d 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -212,10 +212,9 @@ appldata_timer_handler(ctl_table *ctl, int write,
 		return 0;
 	}
 	if (!write) {
-		len = sprintf(buf, appldata_timer_active ? "1\n" : "0\n");
-		if (len > *lenp)
-			len = *lenp;
-		if (copy_to_user(buffer, buf, len))
+		if (copy_to_user(buffer,
+				 appldata_timer_active ? "1\n" : "0\n",
+				 min(2, *lenp))
 			return -EFAULT;
 		goto out;
 	}

-------------------------------diff end--------------------------------


Thanks
-- 
Chen Gang

Asianux Corporation
