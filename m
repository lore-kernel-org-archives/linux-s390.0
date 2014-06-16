From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH tty-next 17/22] tty: Remove ASYNC_CLOSING
Date: Mon, 16 Jun 2014 15:52:51 +0200
Message-ID: <20140616135251.GK732@axis.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <1402924639-5164-18-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402924639-5164-18-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-serial/>
List-Post: <mailto:linux-serial@vger.kernel.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>, linux-cris-kernel@axis.com, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 16, 2014 at 09:17:14AM -0400, Peter Hurley wrote:
> Since at least before 2.6.30, tty drivers that do not drop the tty lock
> while closing cannot observe ASYNC_CLOSING set while holding the
> tty lock; this includes the tty driver's open() and hangup() methods,
> since the tty core calls these methods holding the tty lock.
> 
> For these drivers, waiting for ASYNC_CLOSING to clear while opening
> is not required, since this condition cannot occur. Similarly, even
> when the open() method drops and reacquires the tty lock after
> blocking, ASYNC_CLOSING cannot be set (again, for drivers that
> do not drop the tty lock while closing).
> 
> Now that tty port drivers no longer drop the tty lock while closing
> (since 'tty: Remove tty_wait_until_sent_from_close()'), the same
> conditions apply: waiting for ASYNC_CLOSING to clear while opening
> is not required, nor is re-checking ASYNC_CLOSING after dropping and
> reacquiring the tty lock while blocking (eg., in *_block_til_ready()).
> 
> Since ASYNC_CLOSING is not tested elsewhere, it is safe to remove
> the flag.
> 
> CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
> CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> CC: linux-s390@vger.kernel.org
> CC: Mikael Starvik <starvik@axis.com>

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> CC: linux-cris-kernel@axis.com
> CC: Samuel Ortiz <samuel@sortiz.org>
> CC: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
