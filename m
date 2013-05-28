From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] arch: s390: appldata: using strncpy() and strnlen() instead of sprintf()
Date: Tue, 28 May 2013 13:17:09 +0100
Message-ID: <5895.1369743429@warthog.procyon.org.uk>
References: <51A48EE9.2040401@asianux.com> <51A32D81.2010105@asianux.com> <51A2CC07.5010100@asianux.com> <CAMuHMdXTW3QOxfAfqQXdbSpP4R83srFf7eMfu5fA-75S_Mujsg@mail.gmail.com> <4310.1369736553@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <51A48EE9.2040401@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: dhowells@redhat.com, Geert Uytterhoeven <geert@linux-m68k.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, jang@linux.vnet.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Chen Gang <gang.chen@asianux.com> wrote:

> Your suggestion will improve the speed, but may merge "transferring
> 'protocol' data" and "processing 'protocol' data" together.

Look at it this way: You're having to step very carefully because you are
fully expecting the strings not to be NUL-terminated.  Therefore you probably
avoid using string functions if you can.

In fact, looking at the code, why are you copying the data through an
intermediate buffer at all?  Why not just copy directly to userspace:

	int len;
	char buf[2];

	if (!*lenp || *ppos) {
		*lenp = 0;
		return 0;
	}
	if (!write) {
-		len = sprintf(buf, appldata_timer_active ? "1\n" : "0\n");
+		const char *ptr = appldata_timer_active ? "1\n" : "0\n";
+		size_t len = 2;
		if (len > *lenp)
			len = *lenp;
		if (copy_to_user(buffer, buf, len))
			return -EFAULT;
		goto out;
	}

Put like that, it's fairly obvious what is going on.

David
