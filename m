From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: mmotm 2010-02-10 - BUG at fs/dcache.c:677!
Date: Fri, 12 Feb 2010 13:51:12 +0900
Message-ID: <4B74DE40.5030401@ce.jp.nec.com>
References: <201002110043.o1B0hKxW008835@imap1.linux-foundation.org>	<8576.1265942657@localhost> <20100211191427.6ff9aec6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100211191427.6ff9aec6.akpm@linux-foundation.org>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

(02/12/10 12:14), Andrew Morton wrote:
> On Thu, 11 Feb 2010 21:44:17 -0500 Valdis.Kletnieks@vt.edu wrote:
> 
>> On Wed, 10 Feb 2010 16:17:41 PST, akpm@linux-foundation.org said:
>>> The mm-of-the-moment snapshot 2010-02-10-16-17 has been uploaded to
>>>
>>>    http://userweb.kernel.org/~akpm/mmotm/
>>
>> Hit this at shutdown. ext4 filesystems.  Brought it up to single-user
>> mode, then 'shutdown -h now'.
>>
>> [   58.311786] ------------[ cut here ]------------
>> [   58.312261] kernel BUG at fs/dcache.c:677!
...

> Yeah, Sachin reported that against linux-next too (I think - need to
> check the exact line numbers):
> http://permalink.gmane.org/gmane.linux.file-systems/38148
> 
> It seems to have been met with shrugs thus far.

According to the Sachin's report:
> While running hackbench against today's next-20100208 (9056d31..)
> on a s390 box, came across following BUG.
...
> Did not observe this with next-20100205. Also there doesn't seem to be
> any patches applied to this code after the last release. So not
> sure what could have caused this. Corresponding code is :

So the bug seems introduced between next-20100205 and next-20100208.

Isn't this change missing the equivalent of "dput(old)"?

In patch-v2.6.33-rc7-next-20100208:
> diff --git a/fs/namei.c b/fs/namei.c
> index 94a5e60..a056dad 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -689,33 +689,17 @@ static __always_inline void follow_dotdot(struct nameidata *nd)
...
> -               spin_lock(&dcache_lock);
>                 if (nd->path.dentry != nd->path.mnt->mnt_root) {
> -                       nd->path.dentry = dget(nd->path.dentry->d_parent);
> -                       spin_unlock(&dcache_lock);
> -                       dput(old);
> +                       /* rare case of legitimate dget_parent()... */
> +                       nd->path.dentry = dget_parent(nd->path.dentry);
>                         break;
>                 }

-- 
Jun'ichi Nomura, NEC Corporation
