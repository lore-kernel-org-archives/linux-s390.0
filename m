From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 04 Oct 2016 05:19:26 +0000
Subject: Re: [PATCH -resend 6/6] frv, mn10300, s390, sh: remove empty vga.h
Message-Id: <20161004071926.1b4e3036@mschwide>
References: <20161003090736.19926-1-jslaby@suse.cz>
        <20161003090736.19926-6-jslaby@suse.cz>
In-Reply-To: <20161003090736.19926-6-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-am33-list@redhat.com, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  3 Oct 2016 11:07:36 +0200
Jiri Slaby <jslaby@suse.cz> wrote:

> Provided the architectures do not need any special handling (they seem
> not to support vga at all, actually), there is no need to have an
> empty vga.h. Let them refer to the generic one instead.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-am33-list@redhat.com
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
